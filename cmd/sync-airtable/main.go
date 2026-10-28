// cmd/sync-airtable/main.go
package main

import (
  "context"
  "encoding/json"
  "fmt"
  "log"
  "net/http"
  "net/url"
  "os"
  "time"

  "github.com/joho/godotenv"
  "github.com/jackc/pgx/v5/pgxpool"
)

func readCheckpoint(ctx context.Context, pool *pgxpool.Pool, source string) (time.Time, error) {
  var t time.Time
  err := pool.QueryRow(ctx,
    `SELECT last_modified_time FROM public.sync_state WHERE source = $1`,
    source,
  ).Scan(&t)

  if err == nil {
    return t, nil
  }

  // No row yet
  // pgx returns pgx.ErrNoRows for missing rows
  // (import "github.com/jackc/pgx/v5" if you want to check it explicitly)
  return time.Time{}, nil
}

func writeCheckpoint(ctx context.Context, pool *pgxpool.Pool, source string, t time.Time) error {
  _, err := pool.Exec(ctx, `
    INSERT INTO public.sync_state (source, last_modified_time)
    VALUES ($1, $2)
    ON CONFLICT (source) DO UPDATE
    SET last_modified_time = EXCLUDED.last_modified_time
  `, source, t)
  return err
}
type AirtableClient struct {
  baseID string
  apiKey string
  baseURL string
  http *http.Client
}

func NewAirtableClient(baseID, apiKey string) *AirtableClient {
  return &AirtableClient{
    baseID: baseID,
    apiKey: apiKey,
    baseURL: fmt.Sprintf("https://api.airtable.com/v0/%s", baseID),
    http: &http.Client{Timeout: 30 * time.Second},
  }
}

type AirtableRecord struct {
  ID     string                 `json:"id"`
  Fields map[string]interface{} `json:"fields"`
  // createdTime string `json:"createdTime"`
}

type ListResponse struct {
  Records []AirtableRecord `json:"records"`
  Offset  string           `json:"offset,omitempty"`
}

// simple list records; formula should be url-encoded when calling
func (c *AirtableClient) ListRecords(ctx context.Context, table string, params url.Values) ([]AirtableRecord, error) {
  var all []AirtableRecord
  urlStr := c.baseURL + "/" + url.PathEscape(table)
  for {
    reqURL := urlStr + "?" + params.Encode()
    req, _ := http.NewRequestWithContext(ctx, "GET", reqURL, nil)
    req.Header.Set("Authorization", "Bearer "+c.apiKey)
    resp, err := c.http.Do(req)
    if err != nil {
      return nil, err
    }
    if resp.StatusCode == 429 {
      // backoff
      time.Sleep(30 * time.Second)
      continue
    }
    if resp.StatusCode >= 400 {
      return nil, fmt.Errorf("airtable status %d", resp.StatusCode)
    }
    var lr ListResponse
    if err := json.NewDecoder(resp.Body).Decode(&lr); err != nil {
      resp.Body.Close()
      return nil, err
    }
    resp.Body.Close()
    all = append(all, lr.Records...)
    if lr.Offset == "" {
      break
    }
    params.Set("offset", lr.Offset)
    // small sleep to avoid rate limit bursts
    time.Sleep(150 * time.Millisecond)
  }
  return all, nil
}

func main() {
  if err := godotenv.Load(); err != nil {
    log.Printf("no .env file found; relying on environment variables")
  }
  ctx := context.Background()
  apiKey := os.Getenv("AIRTABLE_API_KEY")
  baseID := os.Getenv("AIRTABLE_BASE_ID")
  dbURL := os.Getenv("DATABASE_URL")
  pool, err := pgxpool.New(ctx, dbURL)
  if err != nil { log.Fatal(err) }
  defer pool.Close()

  c := NewAirtableClient(baseID, apiKey)

  params := url.Values{}
  params.Set("pageSize", "100")
  // Only include the field names you need; include your "Last Modified" computed field
  // params.Set("fields[]", "Name")
  // params.Add("fields[]", "Instructions")
  // params.Add("fields[]", "Meal")
  // params.Add("fields[]", "Serving Size")
  // params.Add("fields[]", "Prep Time")
  // params.Add("fields[]", "Cooking Time")
  // params.Add("fields[]", "Last Modified")


  t0, checkErr := readCheckpoint(ctx, pool, "airtable.recipes")

	if checkErr != nil {
		log.Fatal(checkErr)
	}

	recs, err := c.ListRecords(ctx, "Recipes", params)
	if err != nil { log.Fatal(err) }

	maxLM := t0
	for _, r := range recs {
		lm, err := upsertRecipe(ctx, pool, r)
		if err != nil {
			log.Fatalf("upsert recipe %s: %v", r.ID, err)
		}
		if !lm.IsZero() && lm.After(maxLM) {
			maxLM = lm
		}
	}

	if maxLM.After(t0) {
		if err := writeCheckpoint(ctx, pool, "airtable.recipes", maxLM); err != nil {
			log.Fatal(err)
		}
	}

	log.Printf("synced %d recipes; checkpoint now %s", len(recs), maxLM.UTC().Format(time.RFC3339))
  // filterByFormula example using IS_AFTER (URL-encode the formula)
  // Confirm formula works in Airtable UI first; then URL-encode
  // if !t0.IsZero() {
  //   formula := fmt.Sprintf("IS_AFTER({Last Modified}, \"%s\")", t0.UTC().Format(time.RFC3339))
  //   params.Set("filterByFormula", formula)
  // }

  _ = recs
}

func getString(fields map[string]interface{}, key string) *string {
  v, ok := fields[key]
  if !ok || v == nil { return nil }
  s, ok := v.(string)
  if !ok { return nil }
  return &s
}

func getInt(fields map[string]interface{}, key string) *int {
  v, ok := fields[key]
  if !ok || v == nil { return nil }
  // Airtable numbers usually decode as float64
  switch n := v.(type) {
  case float64:
    i := int(n)
    return &i
  case int:
    i := n
    return &i
  default:
    return nil
  }
}

func getStringSlice(fields map[string]interface{}, key string) []string {
  v, ok := fields[key]
  if !ok || v == nil { return nil }
  arr, ok := v.([]interface{})
  if !ok { return nil }
  out := make([]string, 0, len(arr))
  for _, item := range arr {
    s, ok := item.(string)
    if ok {
      out = append(out, s)
    }
  }
  return out
}

func upsertRecipe(ctx context.Context, pool *pgxpool.Pool, rec AirtableRecord) (time.Time, error) {
  fields := rec.Fields

  namePtr := getString(fields, "Name")
  if namePtr == nil || *namePtr == "" {
    return time.Time{}, fmt.Errorf("recipe %s missing Name", rec.ID)
  }

  instructions := getString(fields, "Instructions")
  meal := getStringSlice(fields, "Meal")

  servingSize := getInt(fields, "Serving Size")
  prep := getInt(fields, "Prep Time")
  cook := getInt(fields, "Cooking Time")

  lmPtr := getString(fields, "Last Modified")
  var lastModified time.Time
  if lmPtr != nil && *lmPtr != "" {
    // Airtable returns ISO timestamps; RFC3339 usually works.
    t, err := time.Parse(time.RFC3339, *lmPtr)
    if err != nil {
      return time.Time{}, fmt.Errorf("recipe %s bad Last Modified %q: %w", rec.ID, *lmPtr, err)
    }
    lastModified = t
  }

  // Convert *int -> *int32 to match your table types if needed.
  toInt32 := func(p *int) *int32 {
    if p == nil { return nil }
    v := int32(*p)
    return &v
  }

  _, err := pool.Exec(ctx, `
    INSERT INTO public.recipes (
      airtable_id,
      airtable_last_modified,
      name,
      instructions,
      meal,
      serving_size,
      prep_time,
      cooking_time
    )
    VALUES ($1,$2,$3,$4,$5,$6,$7,$8)
    ON CONFLICT (airtable_id) DO UPDATE SET
      airtable_last_modified = EXCLUDED.airtable_last_modified,
      name = EXCLUDED.name,
      instructions = EXCLUDED.instructions,
      meal = EXCLUDED.meal,
      serving_size = EXCLUDED.serving_size,
      prep_time = EXCLUDED.prep_time,
      cooking_time = EXCLUDED.cooking_time
  `,
    rec.ID,
    nullTime(lastModified),
    *namePtr,
    derefString(instructions),
    meal, // pgx can encode []string -> text[] with std settings
    servingSize,
    toInt32(prep),
    toInt32(cook),
  )
  return lastModified, err
}

func derefString(p *string) any {
  if p == nil { return nil }
  return *p
}

func nullTime(t time.Time) any {
  if t.IsZero() { return nil }
  return t
}
