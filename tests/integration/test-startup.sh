#!/usr/bin/env bash
# Integration test: Check that nvim starts without errors

set -euo pipefail

NVIM=${1:-nvim}

echo "Testing: nvim starts without errors..."

# Start nvim in headless mode and exit immediately
if $NVIM --headless +"checkhealth nobbz" +qa 2>&1 | tee /tmp/nvim-healthcheck.log; then
  echo "✓ Neovim health check passed"
else
  echo "✗ Neovim health check failed"
  cat /tmp/nvim-healthcheck.log
  exit 1
fi

# Check that nvim can start and quit
if timeout 10 $NVIM --headless +qa; then
  echo "✓ Neovim starts and quits cleanly"
else
  echo "✗ Neovim failed to start or quit"
  exit 1
fi

echo "✓ All integration tests passed!"
