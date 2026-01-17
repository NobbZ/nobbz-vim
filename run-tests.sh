#!/usr/bin/env bash
# Quick test runner script for development
# This script is a convenience wrapper for running tests during development

set -e

echo "==> Running Lua unit tests with busted..."
echo ""

# Check if we're in a nix develop shell
if ! command -v busted &> /dev/null; then
    echo "Error: busted not found in PATH"
    echo "Please run 'nix develop' first to enter the development shell"
    exit 1
fi

# Run tests
busted --verbose tests/

echo ""
echo "==> All tests passed! ✓"
