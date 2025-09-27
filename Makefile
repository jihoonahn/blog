# Swift Blog Makefile
# Personal Blog built with Swift WASM and Supabase

.PHONY: help setup dev build clean install test lint format

# Default target
help: ## Show this help message
	@echo "Swift Blog - Personal Blog built with Swift WASM and Supabase"
	@echo ""
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# Setup
setup: ## Install dependencies and setup the project
	@echo "Setting up Swift Blog..."
	npm install
	swift package resolve
	@echo "Setup complete!"

# Development
dev: ## Start development server
	@echo "Starting development server..."
	npm run dev

dev-swift: ## Build Swift WASM for development
	@echo "Building Swift WASM for development..."
	swift build --triple wasm32-unknown-wasi --product Blog
	cp .build/wasm32-unknown-wasi/debug/Blog.wasm Static/public/

dev-frontend: ## Start frontend development server
	@echo "Starting frontend development server..."
	npm run frontend:dev

# Build
build: ## Build the project for production
	@echo "Building Swift Blog for production..."
	swift build -c release --triple wasm32-unknown-wasi --product Blog
	cp .build/wasm32-unknown-wasi/release/Blog.wasm Static/dist/
	npm run frontend:build
	@echo "Build complete!"

build-swift: ## Build Swift WASM for production
	@echo "Building Swift WASM for production..."
	swift build -c release --triple wasm32-unknown-wasi --product Blog
	cp .build/wasm32-unknown-wasi/release/Blog.wasm Static/dist/

build-frontend: ## Build frontend for production
	@echo "Building frontend for production..."
	npm run frontend:build

# Clean
clean: ## Clean build artifacts
	@echo "Cleaning build artifacts..."
	rm -rf .build
	rm -rf Static/dist
	rm -rf Static/public/*.wasm
	@echo "Clean complete!"

clean-swift: ## Clean Swift build artifacts
	@echo "Cleaning Swift build artifacts..."
	rm -rf .build

clean-frontend: ## Clean frontend build artifacts
	@echo "Cleaning frontend build artifacts..."
	rm -rf Static/dist

# Install
install: ## Install dependencies
	@echo "Installing dependencies..."
	npm install
	swift package resolve

# Test
test: ## Run tests
	@echo "Running tests..."
	swift test

test-swift: ## Run Swift tests
	@echo "Running Swift tests..."
	swift test

# Lint
lint: ## Run linters
	@echo "Running linters..."
	npm run lint || echo "No lint script found"

# Format
format: ## Format code
	@echo "Formatting code..."
	swift format --in-place --recursive Sources/
	npm run format || echo "No format script found"

# Preview
preview: ## Preview production build
	@echo "Starting preview server..."
	npm run frontend:preview

# Netlify
netlify-build: ## Build for Netlify deployment
	@echo "Building for Netlify..."
	make build

netlify-dev: ## Start Netlify development
	@echo "Starting Netlify development..."
	make dev

# Database
db-setup: ## Setup database (requires Supabase CLI)
	@echo "Setting up database..."
	supabase db reset || echo "Supabase CLI not found or not configured"

db-migrate: ## Run database migrations
	@echo "Running database migrations..."
	supabase db push || echo "Supabase CLI not found or not configured"

# Docker
docker-build: ## Build Docker image
	@echo "Building Docker image..."
	docker build -t swift-blog .

docker-run: ## Run Docker container
	@echo "Running Docker container..."
	docker run -p 3000:3000 swift-blog

# Utilities
check: ## Check project health
	@echo "Checking project health..."
	swift package resolve
	npm audit
	@echo "Project health check complete!"

update: ## Update dependencies
	@echo "Updating dependencies..."
	swift package update
	npm update

# Environment
env-example: ## Copy environment example
	@echo "Copying environment example..."
	cp .env.example .env
	@echo "Please edit .env with your configuration"

# Documentation
docs: ## Generate documentation
	@echo "Generating documentation..."
	swift package generate-documentation || echo "Documentation generation not available"

# Release
release: ## Create a release build
	@echo "Creating release build..."
	make clean
	make build
	@echo "Release build complete!"

# Quick commands
q: dev ## Quick development start
b: build ## Quick build
c: clean ## Quick clean
s: setup ## Quick setup
