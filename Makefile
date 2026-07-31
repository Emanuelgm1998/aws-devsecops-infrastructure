.DEFAULT_GOAL := help

APP_PORT ?= 3000
APP_URL ?= http://127.0.0.1:$(APP_PORT)

.PHONY: help start stop restart logs status health test

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Available commands:\n"} /^[a-zA-Z_-]+:.*## / {printf "  %-10s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

start: ## Build and start the local product demo
	docker compose up --build --detach --wait
	@echo "Application ready at $(APP_URL)"

stop: ## Stop the local product demo
	docker compose down

restart: stop start ## Rebuild and restart the local product demo

logs: ## Follow application logs
	docker compose logs --follow app

status: ## Show container and health status
	docker compose ps

health: ## Verify the running application
	curl --fail --silent --show-error "$(APP_URL)/health"
	@echo

test: ## Run checks that do not require an AWS account
	terraform fmt -check -recursive
	docker build --tag aws-devsecops-infrastructure:test app/
	docker run --rm aws-devsecops-infrastructure:test node --check index.js
