package httpapi

import (
	"encoding/json"
	"net/http"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

type Handlers struct {
	DB *pgxpool.Pool
}

func (h *Handlers) Healthz(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte("ok"))
}

type Recipe struct {
	ID          int64   `json:"id"`
	Name        string  `json:"name"`
	TypeID      *int64  `json:"typeId,omitempty"`
	TypeName    *string `json:"typeName,omitempty"`
	Instructions *string `json:"instructions,omitempty"`
	PrepTime    *int32  `json:"prepTime,omitempty"`
	CookingTime *int32  `json:"cookingTime,omitempty"`
	ServingSize *int32  `json:"servingSize,omitempty"`
	CreatedAt   *string `json:"createdAt,omitempty"`
	UpdatedAt   *string `json:"updatedAt,omitempty"`
}

func (h *Handlers) Recipes(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		h.listRecipes(w, r)
	default:
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
	}
}

func (h *Handlers) listRecipes(w http.ResponseWriter, r *http.Request) {
	rows, err := h.DB.Query(r.Context(), `
		SELECT
			r.id,
			r.name,
			r.type_id,
			rt.name AS type_name,
			r.instructions,
			r.prep_time,
			r.cooking_time,
			r.serving_size,
			r.created_at,
			r.updated_at
		FROM recipes r
		LEFT JOIN recipe_types rt ON rt.id = r.type_id
		ORDER BY r.id DESC
		LIMIT 200
	`)
	if err != nil {
		writeJSON(w, http.StatusInternalServerError, map[string]any{
			"message": "failed to query recipes",
			"error":   err.Error(),
		})
		return
	}
	defer rows.Close()

	out := make([]Recipe, 0, 64)

	for rows.Next() {
		var rec Recipe

		// Use pgx scanning into pointers where nulls are possible
		var (
			typeID      *int64
			typeName    *string
			instructions *string
			prepTime    *int32
			cookingTime *int32
			servingSize *int32
			createdAt   *time.Time
			updatedAt   *time.Time
		)

		// Scan timestamps as text to avoid timezone formatting surprises at this stage
		// (We can tighten this later with time.Time and RFC3339.)
		if err := rows.Scan(
			&rec.ID,
			&rec.Name,
			&typeID,
			&typeName,
			&instructions,
			&prepTime,
			&cookingTime,
			&servingSize,
			&createdAt,
			&updatedAt,
		); err != nil {
			writeJSON(w, http.StatusInternalServerError, map[string]any{
				"message": "failed to scan recipe row",
				"error":   err.Error(),
			})
			return
		}

		rec.TypeID = typeID
		rec.TypeName = typeName
		rec.Instructions = instructions
		rec.PrepTime = prepTime
		rec.CookingTime = cookingTime
		rec.ServingSize = servingSize

  if createdAt != nil {
    s := createdAt.UTC().Format(time.RFC3339)
    rec.CreatedAt = &s
  }
  if updatedAt != nil {
    s := updatedAt.UTC().Format(time.RFC3339)
    rec.UpdatedAt = &s
  }

		out = append(out, rec)
	}

	if rows.Err() != nil {
		writeJSON(w, http.StatusInternalServerError, map[string]any{
			"message": "row iteration error",
			"error":   rows.Err().Error(),
		})
		return
	}

	writeJSON(w, http.StatusOK, out)
}

func writeJSON(w http.ResponseWriter, status int, v any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_ = json.NewEncoder(w).Encode(v)
}
