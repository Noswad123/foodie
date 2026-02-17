package common

import (
	"github.com/jackc/pgx/v5/pgxpool"
)

type Repo struct {
	DB *pgxpool.Pool
}

func NewRepo(db *pgxpool.Pool) *Repo {
	return &Repo{DB: db}
}
