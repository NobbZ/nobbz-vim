#!/usr/bin/env bash
# Test runner script for local development

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_section() {
  echo -e "\n${YELLOW}==== $1 ====${NC}\n"
}

print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
  echo -e "${RED}✗ $1${NC}"
}

# Check if we're in a Nix flake directory
if [ ! -f "flake.nix" ]; then
  print_error "Not in a Nix flake directory"
  exit 1
fi

print_section "Building neovim package"
if nix build .#neovim --print-build-logs; then
  print_success "Neovim package built successfully"
else
  print_error "Failed to build neovim package"
  exit 1
fi

print_section "Running Lua tests"
if nix build .#checks.x86_64-linux.lua-tests --print-build-logs; then
  print_success "Lua tests passed"
else
  print_error "Lua tests failed"
  exit 1
fi

print_section "Running integration tests"
if nix build .#checks.x86_64-linux.integration-tests --print-build-logs; then
  print_success "Integration tests passed"
else
  print_error "Integration tests failed"
  exit 1
fi

print_section "Running flake checks"
if nix flake check --print-build-logs; then
  print_success "Flake checks passed"
else
  print_error "Flake checks failed"
  exit 1
fi

print_section "All tests passed!"
echo -e "${GREEN}✓ All checks completed successfully${NC}"
