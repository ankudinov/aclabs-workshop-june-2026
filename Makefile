CURRENT_DIR := $(shell pwd)

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: serve
serve: ## Serve slides on http://localhost:8080
	@$(CURRENT_DIR)/serve-slides.sh

.PHONY: stop
stop: ## Stop serving slides
	@if command -v podman >/dev/null 2>&1; then \
		podman rm -f marp >/dev/null 2>&1 || true; \
	elif command -v docker >/dev/null 2>&1; then \
		docker rm -f marp >/dev/null 2>&1 || true; \
	else \
		echo "ERROR: Failed to find container engine. Please install docker or podman." >&2; \
		exit 1; \
	fi
