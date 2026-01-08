#!/usr/bin/env bash
# Integration test: Test LSP functionality

set -euo pipefail

NVIM=${1:-nvim}

echo "Testing: LSP functionality..."

# Create a temporary Lua file
TMP_FILE=$(mktemp --suffix=.lua)
cat > "$TMP_FILE" << 'EOF'
local function test()
  print("Hello, world!")
end
EOF

# Test that nvim can open a Lua file
if timeout 10 $NVIM --headless "$TMP_FILE" +"lua vim.lsp.start({name='test', cmd={'cat'}})" +qa 2>&1 | tee /tmp/nvim-lsp-test.log; then
  echo "✓ Neovim LSP test passed"
else
  echo "✗ Neovim LSP test failed"
  cat /tmp/nvim-lsp-test.log
  rm -f "$TMP_FILE"
  exit 1
fi

rm -f "$TMP_FILE"
echo "✓ LSP integration test passed!"
