.PHONY: up down logs ps dbshell migrate-up migrate-down

up:
	docker compose up -d --build

down:
	docker compose down

logs:
	docker compose logs -f --tail=200

ps:
	docker compose ps

dbshell:
	docker exec -it foodie-db psql -U foodie -d foodie

migrate-up:
	migrate -path backend/migrations -database "$$DATABASE_URL" up

migrate-down:
	migrate -path backend/migrations -database "$$DATABASE_URL" down 1
