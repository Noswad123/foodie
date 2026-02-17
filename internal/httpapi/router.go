package httpapi

import (
	"net/http"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/Noswad123/foodie/internal/httpapi/recipes"
	"github.com/Noswad123/foodie/internal/httpapi/common"
)

func NewRouter(db *pgxpool.Pool) http.Handler {
	mux := http.NewServeMux()

	cr := common.NewRepo(db)

	mux.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		_, _ = w.Write([]byte("ok"))
	})

	mux.Handle("/api/v1/recipes", recipes.NewHandler(cr))

	return mux
}
