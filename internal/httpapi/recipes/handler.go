package recipes

import (
	"net/http"

	"github.com/Noswad123/foodie/internal/httpx"
	"github.com/Noswad123/foodie/internal/httpapi/common"
)

type Handler struct {
	repo *Repo
}

func NewHandler(cr *common.Repo) *Handler {
	return &Handler{repo: NewRepo(cr)}
}

// ServeHTTP keeps routing decisions close to the feature.
func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		h.list(w, r)
	default:
		httpx.MethodNotAllowed(w, http.MethodGet)
	}
}

func (h *Handler) list(w http.ResponseWriter, r *http.Request) {
	out, err := h.repo.List(r.Context(), 200)
	if err != nil {
		httpx.Fail(w, http.StatusInternalServerError, "failed to query recipes", err)
		return
	}
	httpx.JSON(w, http.StatusOK, out)
}
