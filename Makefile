DOCKER=docker
COMPOSE=docker compose

.PHONY: install
install: build start ## Installs and starts project

.PHONY: start
start: ## Start project
	@$(COMPOSE) up -d --remove-orphans
	@echo -e "\e[35m\nIndex :  http://localhost:3000\e[0m"

.PHONY: stop
stop: ## Stop project
	@$(COMPOSE) down

.PHONY: restart
restart: stop start ## Restart project

.PHONY: build
build: build-front build-back ## Builds images

.PHONY: build-front
build-front: ## Builds front image
	@$(DOCKER) build front

.PHONY: build-back
build-back: ## Builds back image
	@$(DOCKER) build back