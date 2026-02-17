# Foodie

![Foodie](img/foodie.png)


## What is Foodie?
An app to help manage inventory in the kitchen and store recipes

Initializing migrations
brew install golang-migrate
backend/migrations/
  000001_init.up.sql
  000001_init.down.sql

migrate -path backend/migrations \
  -database "postgres://foodie:foodie@localhost:2022/foodie?sslmode=disable" up


go run ./cmd/server

bun run dev --open


Using:
  - Go for the backend
  - Bun for the frontend
  - Python to sync records from Airtable with my app
