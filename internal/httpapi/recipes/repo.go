package recipes

import (
	"context"
	"time"

	"github.com/Noswad123/foodie/internal/httpapi/common"
)

type Repo struct {
	*common.Repo
}

func NewRepo(cr *common.Repo) *Repo {
	return &Repo{Repo: cr}
}

func (rp *Repo) List(ctx context.Context, limit int) ([]Recipe, error) {
	if limit <= 0 || limit > 1000 {
		limit = 200
	}

	rows, err := rp.DB.Query(ctx, `
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
		LIMIT $1
	`, limit)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	out := make([]Recipe, 0, 64)

	for rows.Next() {
		var rec Recipe
		var createdAt, updatedAt *time.Time

		if err := rows.Scan(
			&rec.ID,
			&rec.Name,
			&rec.TypeID,
			&rec.TypeName,
			&rec.Instructions,
			&rec.PrepTime,
			&rec.CookingTime,
			&rec.ServingSize,
			&createdAt,
			&updatedAt,
		); err != nil {
			return nil, err
		}

		// Keep JSON strings if you want stable formatting
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

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return out, nil
}
