package httpapi

import (
	"net/http"
)

func NewRouter(h *Handlers) http.Handler {
	mux := http.NewServeMux()
	mux.HandleFunc("/healthz", h.Healthz)
	mux.HandleFunc("/api/v1/recipes", h.Recipes)
	return mux
}

