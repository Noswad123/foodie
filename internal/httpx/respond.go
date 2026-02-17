package httpx

import (
	"encoding/json"
	"net/http"
)

type Error struct {
	Message string `json:"message"`
	Error   string `json:"error,omitempty"`
}

func JSON(w http.ResponseWriter, status int, v any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_ = json.NewEncoder(w).Encode(v)
}

func Fail(w http.ResponseWriter, status int, msg string, err error) {
	out := Error{Message: msg}
	if err != nil {
		out.Error = err.Error()
	}
	JSON(w, status, out)
}

func MethodNotAllowed(w http.ResponseWriter, allowed ...string) {
	if len(allowed) > 0 {
		w.Header().Set("Allow", joinAllow(allowed))
	}
	http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
}

func joinAllow(methods []string) string {
	if len(methods) == 0 {
		return ""
	}
	s := methods[0]
	for i := 1; i < len(methods); i++ {
		s += ", " + methods[i]
	}
	return s
}
