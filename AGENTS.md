# AGENTS.md - Development Guidelines for nobbz-vim

## Overview

This repository contains a Nix flake-based Neovim configuration. It provides a reproducible, declarative Neovim setup with custom plugins and LSP configurations.

**Key Technologies:** Nix, Lua, Python (build scripts)\
**Target:** Personal Neovim configuration using Nix flakes for reproducibility

## Build/Lint/Test Commands

This project REQUIRES Nix with flakes enabled. All operations fail without it.

### Core Commands

- **Build the configuration:** `nix build` or `nix build .#neovim`
  - Builds Neovim with all plugins (takes 1-2 minutes on first build)
  - Output in `./result` symlink

- **Run directly:** `nix run` or `nix run .#neovim`
  - Launches Neovim with the configuration
  - Useful for quick testing

- **Enter dev shell:** `nix develop`
  - Provides: `nil`, `stylua`, `npins`, `alejandra`, `basedpyright`, `emmy-lua-code-style`
  - Creates `.luarc.json` symlink for LSP support
  - Use this for making changes to Lua code

- **Format code:** `nix fmt`
  - Formats all Nix files with `alejandra`
  - Formats all Lua files with `emmy-lua-code-style` (CodeFormat)
  - **ALWAYS run before committing** - formatting is strict
  - Respects `.editorconfig` and `.stylua.toml`

- **Add new plugin:** `nix run .#add-plugin <name> <owner/repo>`
  - Example: `nix run .#add-plugin telescope nvim-telescope/telescope.nvim`
  - Adds plugin to `npins/sources.json` with `nvim-` prefix
  - Optionally use `-b branch` or `-t gitlab` flags

- **Validate flake:** `nix flake check`
  - Validates flake structure
  - Checks `add-plugin` and `update-plugins` packages build successfully

### Testing & Validation

- **No traditional tests** - validation is entirely manual
- **Integration testing:** `nix build` + `nix run` + `:checkhealth nobbz` in Neovim
- **No single test command** - build and health check serve as integration tests
- **Custom health check system:** Use `:checkhealth nobbz` (not `:checkhealth`)
- **Plugin validation:** Test individual plugins by loading them in Neovim and checking functionality
- **LSP validation:** Verify LSP servers work by opening files of supported languages and checking `:checkhealth nobbz`

## Code Style Guidelines

### Lua Style Requirements

Follow the [luarocks style guide](https://github.com/luarocks/lua-style-guide) with these modifications:

- **Indentation:** 2 spaces
- **Strings:** Double quotes preferred (`"`)
- **Tables:** Trailing commas always
- **Function calls:** Always use parentheses
- **Variables:** Use `local` for all variables (no globals)
- **Documentation:** EmmyLua annotations for functions
- **Lazy loading:** Use `nobbz.lazy` when possible
- **Formatting:** Both `stylua` and `emmy-lua-code-style` must pass

**Example:**

```lua
---@param modname string
---@return function
local function rf(modname)
  return function()
    require(modname)
  end
end
```

### Nix Style Requirements

- **Clear distinction:** Maintain separation between flake-parts modules and package definitions
- **Plugin organization:** In `plugins/default.nix`:
  - Plugins sorted alphabetically
  - No new plugins in first section of `optionalPlugins` set (marked with TODO comment for eager loading)
- **Flake inputs:** Keep pinned - commit `flake.lock` changes when updated

### General Guidelines

- **Formatting:** Run `nix fmt` before every commit (REQUIRED)
- **Configuration files:**
  - `.editorconfig` - Lua formatting rules (2 spaces, double quotes, comma separators)
  - `.stylua.toml` - Stylua configuration (column width 120, sort requires enabled)
- **Imports:** Keep organized and sorted where applicable
- **Error handling:** Register LSPs with `require("nobbz.health").register_lsp("lsp-name")`
- **Plugin loading:** `false` = mandatory (start), `true` = optional (opt) in `optionalPlugins`
- **Schema support for JSON/YAML/TOML:** LSPs for jsonls, yamlls, taplo are configured with SchemaStore for schema validation via `$schema` keys. Ensure files have proper schemas for completions and diagnostics.

## Copilot Structure and Workflows

### Repository Overview

This is a Neovim configuration managed as a Nix flake. The repository provides a reproducible, declarative Neovim setup with custom plugins and LSP configurations.

**Key Facts:**

- **Purpose:** Personal Neovim configuration using Nix flakes for reproducibility
- **Size:** Small (~600KB, ~1900 lines of Nix/Lua code)
- **Languages:** Nix, Lua, Python (for build scripts)
- **Target Users:** Developers in the Nix ecosystem
- **Try it:** `nix run github:nobbz/nobbz-vim` (requires Nix with flakes enabled)

### Project Structure

**Root Files:**

- `flake.nix` - Main flake definition, defines packages and dev shell
- `flake.lock` - Lock file for flake inputs (auto-generated, commit changes)
- `nix/mnw/default.nix` - MNW (Minimal Neovim Wrapper) configuration for Neovim package
- `nix/mnw.nix` - MNW integration module, defines `nobbzvim` and `nobbzvide` packages
- `.editorconfig` - Lua formatting rules (2 spaces, double quotes, comma separators)
- `.stylua.toml` - Stylua configuration (mostly defaults explicitly set)
- `.envrc` - direnv configuration for automatic dev shell loading
- `.gitignore` - Ignores `.luarc.json` (generated) and `.direnv`

**Directories:**

- `plugins/` - Plugin management (flake-parts module, builds vim plugins from npins)
- `plugins/nobbz/` - Custom plugin containing all configuration
- `plugins/nobbz/lua/nobbz/` - Lua configuration modules (one file per feature)
- `bin/` - Utility scripts (`add-plugin.py`, `update-plugins.py`)
- `npins/` - Dependency pinning (`sources.json`)
- `pkgs/` - Custom packages (markdown-oxide LSP)

### Common Workflows

**Making changes to Lua configuration:**

1. `nix develop` - enter dev shell
2. Edit files in `plugins/nobbz/lua/nobbz/`
3. Test with `:checkhealth nobbz` in Neovim
4. `nix fmt` - format before committing

**Adding a new plugin:**

1. `nix run .#add-plugin <name> <owner/repo>`
2. Edit `plugins/default.nix` - add plugin name to `optionalPlugins` set with `true` (opt) or `false` (start)
3. Configure in `plugins/nobbz/lua/nobbz/` - create new file or edit existing
4. Add lazy loading spec if optional plugin
5. `nix build` - verify it builds
6. `nix fmt` - format before committing

### Validation Steps

Before submitting changes:

1. **Format:** `nix fmt` (REQUIRED - catches style issues)
2. **Build:** `nix build` (verifies Nix evaluation and package builds)
3. **Test run:** `nix run` (launches Neovim to verify it works)
4. **Check health:** In Neovim, run `:checkhealth nobbz` (verifies programs and LSP configs)
5. **Flake check:** `nix flake check` (validates flake structure)

### Common Pitfalls

1. **Nix not available:** This project REQUIRES Nix. All operations fail without it.
2. **Build failures after adding plugins:**
   - Check `plugins/default.nix` - plugin must be in `optionalPlugins` set
   - Verify plugin exists in `npins/sources.json` with `nvim-` prefix
3. **Lua formatting fails:** Run `nix develop` first, check `.editorconfig` compliance
4. **Plugin not loading:** Check `optionalPlugins` set - `false` = mandatory, `true` = optional
5. **LSP not working:** LSP binaries added to PATH in `nix/mnw/default.nix` via `extraBinPath`, register with health system

## Additional Notes

- **No GitHub Actions workflows** - validation is entirely manual
- **Custom health check system** - use `:checkhealth nobbz` not `:checkhealth`
- **Lazy loading via lz.n** - not using lazy.nvim, custom system in `lazy/init.lua`
- **MNW (Minimal Neovim Wrapper)** - Used for wrapping Neovim with plugins and runtime dependencies, configured in `nix/mnw/default.nix`
- **Neovide supported** - GUI wrapper defined in `nix/mnw.nix`
- **direnv integration** - `.envrc` auto-loads dev shell if direnv installed
