# Grimorium CLI - Makefile
.PHONY: help build run clean test fmt vet mod-tidy install uninstall

# Variables
APP_NAME = cast
GO_FILES = $(shell find . -name "*.go" -type f -not -path "./vendor/*")
BUILD_DIR = bin
MAIN_PACKAGE = ./cmd/cli

# Default target
all: build

# Help target - displays available commands
help: ## Display this help screen
	@echo "Grimorium CLI - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Build the application
build: ## Build the application
	@echo "Building $(APP_NAME)..."
	@mkdir -p $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(APP_NAME) $(MAIN_PACKAGE)
	@echo "Build complete: $(BUILD_DIR)/$(APP_NAME)"

# Build for multiple platforms
build-all: ## Build for multiple platforms (Linux, macOS, Windows)
	@echo "Building for multiple platforms..."
	@mkdir -p $(BUILD_DIR)
	GOOS=linux GOARCH=amd64 go build -o $(BUILD_DIR)/$(APP_NAME)-linux-amd64 $(MAIN_PACKAGE)
	GOOS=darwin GOARCH=amd64 go build -o $(BUILD_DIR)/$(APP_NAME)-darwin-amd64 $(MAIN_PACKAGE)
	GOOS=darwin GOARCH=arm64 go build -o $(BUILD_DIR)/$(APP_NAME)-darwin-arm64 $(MAIN_PACKAGE)
	GOOS=windows GOARCH=amd64 go build -o $(BUILD_DIR)/$(APP_NAME)-windows-amd64.exe $(MAIN_PACKAGE)
	@echo "Cross-platform builds complete"

# Run the application
run: ## Run the application
	go run $(MAIN_PACKAGE)

# Run with arguments (use: make run-args ARGS="translate hello")
run-args: ## Run with arguments (use: make run-args ARGS="translate hello")
	go run $(MAIN_PACKAGE) $(ARGS)

# Install the application to GOPATH/bin
install: ## Install the application
	go install $(MAIN_PACKAGE)

# Uninstall the application
uninstall: ## Uninstall the application
	rm -f $(shell go env GOPATH)/bin/$(APP_NAME)

# Run tests
test: ## Run all tests
	go test -v ./...

# Run tests with coverage
test-coverage: ## Run tests with coverage report
	go test -v -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report generated: coverage.html"

# Format code
fmt: ## Format Go code
	go fmt ./...

# Run go vet
vet: ## Run go vet
	go vet ./...

# Run golint (requires golint to be installed)
lint: ## Run golint (install with: go install golang.org/x/lint/golint@latest)
	@command -v golint >/dev/null 2>&1 || { echo "golint not installed. Run: go install golang.org/x/lint/golint@latest"; exit 1; }
	golint ./...

# Download dependencies
mod-download: ## Download Go modules
	go mod download

# Tidy up dependencies
mod-tidy: ## Clean up go.mod and go.sum
	go mod tidy

# Verify dependencies
mod-verify: ## Verify dependencies
	go mod verify

# Clean build artifacts
clean: ## Clean build artifacts
	rm -rf $(BUILD_DIR)
	rm -f coverage.out coverage.html

# Development setup
dev-setup: mod-download ## Setup development environment
	@echo "Development environment setup complete"

# Check for security vulnerabilities
security-check: ## Check for security vulnerabilities (requires govulncheck)
	@command -v govulncheck >/dev/null 2>&1 || { echo "govulncheck not installed. Run: go install golang.org/x/vuln/cmd/govulncheck@latest"; exit 1; }
	govulncheck ./...

# Full check - format, vet, test
check: fmt vet test ## Run format, vet, and tests

# Release preparation
release: clean fmt vet test build-all ## Prepare for release (clean, format, vet, test, build all platforms)
	@echo "Release preparation complete"

# Show project info
info: ## Show project information
	@echo "Project: $(APP_NAME)"
	@echo "Go version: $(shell go version)"
	@echo "Git commit: $(shell git rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
	@echo "Build dir: $(BUILD_DIR)"
	@echo "Main package: $(MAIN_PACKAGE)"