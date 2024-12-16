DOCKER=docker
DOCKER_CMD=docker exec
DOCKER_CLI=docker exec -it
COMPOSE=docker compose

.PHONY: install
install: build install-packages ## Installs and starts project

.PHONY: build
build: build-front build-back ## Builds images

.PHONY: build-front
build-front: ## Builds front image
	@$(DOCKER) build front

.PHONY: build-back
build-back: ## Builds back image
	@$(DOCKER) build back

.PHONY: install-packages
install-packages: install-packages-front install-packages-back

.PHONY: install-packages-front
install-packages-front: start
	@$(DOCKER_CMD) command-craftor-main-front-1 npm install

install-packages-back: start
	@$(DOCKER_CMD) command-craftor-main-back-1 npm install

.PHONY: start
start: ## Start project
	@$(COMPOSE) up -d --remove-orphans
	@echo -e "\e[35m\nIndex :  http://localhost:3000\e[0m"

.PHONY: stop
stop: ## Stop project
	@$(COMPOSE) down

.PHONY: restart
restart: stop start ## Restart project

bash-front: start
	@$(DOCKER_CLI) command-craftor-main-front-1 /bin/sh

bash-back: start
	@$(DOCKER_CLI) command-craftor-main-back-1 /bin/sh
