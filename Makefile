COMPOSE := docker compose
COMPOSE_FILE := compose.yaml
ENV_FILE := .env

up:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d --build

restart:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) restart

down:
	$(COMPOSE) -f $(COMPOSE_FILE) down --remove-orphans

logs:
	$(COMPOSE) -f $(COMPOSE_FILE) logs -f
