# Copilot Onboarding Instructions for `nobbz-vim`

## Repository Overview

This is a Neovim configuration managed as a Nix flake. The repository provides a reproducible, declarative Neovim setup with custom plugins and LSP configurations.

**Key Facts:**
- **Purpose:** Personal Neovim configuration using Nix flakes for reproducibility
- **Size:** Small (~600KB, ~1900 lines of Nix/Lua code)
- **Languages:** Nix, Lua, Python (for build scripts)
- **Target Users:** Developers in the Nix ecosystem
- **Try it:** `nix run github:nobbz/nobbz-vim` (requires Nix with flakes enabled)

## Build and Development Commands

**Prerequisites:** Nix with flakes enabled. This project REQUIRES Nix - all build/test commands use Nix.

### Core Commands (all require Nix)

1. **Build the package:** `nix build` or `nix build .#neovim`
   - Builds the Neovim configuration with all plugins
   - Output in `./result` symlink
   - Takes 1-2 minutes on first build (downloads dependencies)

2. **Run directly:** `nix run` or `nix run .#neovim`
   - Launches Neovim with the configuration
   - Useful for quick testing

3. **Enter dev shell:** `nix develop`
   - Provides: `nil`, `stylua`, `npins`, `alejandra`, `basedpyright`, `emmy-lua-code-style`, `cue`
   - Creates `.luarc.json` symlink for LSP support
   - Use this for making changes to Lua code or generating workflows

4. **Format code:** `nix fmt`
   - Formats all Nix files with `alejandra`
   - Formats all Lua files with `emmy-lua-code-style` (CodeFormat)
   - **ALWAYS run before committing** - formatting is strict
   - Respects `.editorconfig` and `.stylua.toml`

5. **Update flake lock:** `nix flake update --commit-lock-file`
   - Updates all flake inputs (nixpkgs, etc.)
   - Automatically commits the lock file

6. **Update plugins:** `nix run .#update-plugins`
   - Updates all nvim-* plugins tracked in `npins/sources.json`
   - Commits each plugin update separately
   - May take several minutes

7. **Add new plugin:** `nix run .#add-plugin <name> <owner/repo>`
   - Example: `nix run .#add-plugin telescope nvim-telescope/telescope.nvim`
   - Adds plugin to `npins/sources.json` with `nvim-` prefix
   - Optionally use `-b branch` or `-t gitlab` flags

8. **Run checks:** `nix flake check`
   - Validates flake structure
   - Runs all test suites (Lua unit tests, integration tests)
   - Checks `add-plugin` and `update-plugins` packages build successfully

9. **Run tests:** `./scripts/run-tests.sh` or individual test suites:
   - `nix build .#checks.x86_64-linux.lua-tests` - Run Lua unit tests
   - `nix build .#checks.x86_64-linux.integration-tests` - Run integration tests

10. **Generate workflows:** `make workflows`
    - Generates GitHub Actions workflows from CUE definitions in `cicd/`
    - Run `make check` to verify workflows match their definitions
    - Run `make fmt` to format CUE files

### Common Workflows

**Making changes to Lua configuration:**
1. `nix develop` - enter dev shell
2. Edit files in `plugins/nobbz/lua/nobbz/`
3. Test with `:checkhealth nobbz` in Neovim
4. `nix fmt` - format before committing

**Adding a new plugin:**
1. `nix run .#add-plugin <name> <owner/repo>`
2. Edit `plugins/default.nix` - add plugin name to `optionalPlugins` dict with `true` (opt) or `false` (start)
3. Configure in `plugins/nobbz/lua/nobbz/` - create new file or edit existing
4. Add lazy loading spec if optional plugin
5. `nix build` - verify it builds
6. `nix fmt` - format before committing

## Project Structure

### Root Files
- `flake.nix` - Main flake definition, defines packages and dev shell
- `flake.lock` - Lock file for flake inputs (auto-generated, commit changes)
- `nvim.nix` - Neovim package definition, wraps with runtime dependencies
- `nvide.nix` - Neovide (GUI) wrapper using wrapper-manager
- `Makefile` - Workflow generation targets (workflows, check, fmt)
- `.editorconfig` - Lua formatting rules (2 spaces, double quotes, comma separators)
- `.stylua.toml` - Stylua configuration (mostly defaults explicitly set)
- `.envrc` - direnv configuration for automatic dev shell loading
- `.gitignore` - Ignores `.luarc.json` (generated) and `.direnv`

### Directories

**`plugins/`** - Plugin management
- `default.nix` - Flake-parts module, builds vim plugins from npins, defines `optionalPlugins` dict
- `nobbz/` - Custom plugin containing all configuration
  - `default.nix` - Builds the nobbz plugin
  - `lua/nobbz/` - Lua configuration modules
  - `plugin/nobbz.lua` - Plugin entry point

**`plugins/nobbz/lua/nobbz/`** - Configuration modules (one file per feature)
- `init.lua` - Main entry point, loads all submodules
- `lazy/` - Lazy loading system (borrowed from ViperML)
- `lsp/` - LSP server configurations (one file per language)
- `health.lua` - Custom health check system
- Feature-specific files: `blink.lua`, `telescope.lua`, `lualine.lua`, etc.

**`bin/`** - Utility scripts
- `default.nix` - Flake-parts module, exposes scripts as packages
- `add-plugin.py` / `add-plugin.nix` - Script to add plugins via npins
- `update-plugins.py` / `update-plugins.nix` - Script to update all plugins

**`npins/`** - Dependency pinning
- `sources.json` - Pinned sources (plugins, neovim, dependencies)
- `default.nix` - npins library (auto-generated, don't edit)

**`pkgs/`** - Custom packages
- `oxide.nix` - Builds markdown-oxide LSP from pinned source

**`tests/`** - Test infrastructure
- `default.nix` - Flake-parts module defining test checks
- `lua/` - Lua unit tests using busted framework (files ending in `_spec.lua`)
- `integration/` - Integration tests (bash scripts testing nvim behavior)
- `README.md` - Testing documentation

**`cicd/`** - Workflow generation
- `workflows.cue` - Base workflow definitions with common steps
- `pull-check.cue` - Pull request check workflow definition
- `check-generated.cue` - Workflow to verify generated files
- `README.md` - Workflow generation documentation

**`scripts/`** - Development scripts
- `run-tests.sh` - Convenient test runner for local development

**`cue.mod/`** - CUE module configuration
- `module.cue` - CUE module definition with dependencies

**`.github/`** - GitHub configuration
- `copilot-instructions.md` - This file
- `workflows/` - Generated GitHub Actions workflows (DO NOT edit directly)

### Key Configuration Files

**Lua style requirements (from `.coderabbit.yaml`):**
- Use `local` for all variables
- Use lazy loading via `nobbz.lazy` when possible
- Follow luarocks style guide with 2-space indentation
- Double quotes for strings
- Trailing commas in tables
- Always use call parentheses

**Nix style requirements:**
- Clear distinction between flake-parts modules and package definitions
- Plugins in `plugins/default.nix` sorted alphabetically
- No new plugins in first section of `optionalPlugins` (TODO comment indicates eager loading section)

## Common Pitfalls and Solutions

1. **Nix not available:** This project REQUIRES Nix. All operations fail without it. Do not attempt workarounds.

2. **Build failures after adding plugins:**
   - Check `plugins/default.nix` - plugin must be in `optionalPlugins` dict
   - Verify plugin exists in `npins/sources.json` with `nvim-` prefix
   - Run `nix flake lock --update-input nixpkgs` if package not found

3. **Lua formatting fails:**
   - Run `nix develop` first to ensure tools available
   - Check `.editorconfig` is respected
   - Both `stylua` and `emmy-lua-code-style` must pass

4. **Plugin not loading:**
   - Check `optionalPlugins` in `plugins/default.nix` - `false` = mandatory (start), `true` = optional (opt)
   - If optional, must have lazy loading spec in Lua config
   - Verify in Neovim with `:checkhealth nobbz`

5. **LSP not working:**
   - LSP binaries added to PATH in `nvim.nix` (see `generatedWrapperArgs`)
   - Health check system in `health.lua` tracks LSP configs
   - Register LSP with `require("nobbz.health").register_lsp("lsp-name")`

## Validation Steps

Before submitting changes:

1. **Format:** `nix fmt` (REQUIRED - catches style issues)
2. **Build:** `nix build` (verifies Nix evaluation and package builds)
3. **Run tests:** `./scripts/run-tests.sh` or `nix flake check` (runs all tests)
4. **Test run:** `nix run` (launches Neovim to verify it works)
5. **Check health:** In Neovim, run `:checkhealth nobbz` (verifies programs and LSP configs)
6. **Verify workflows:** If you modified CUE files, run `make workflows && make check`
7. **Update instructions:** After major refactors, verify `.github/copilot-instructions.md` is still accurate

**Automated CI/CD** - Pull requests automatically run workflows that build, test, and validate:
- `pull-check.yml` - Builds package, runs all tests, validates flake
- `check-generated.yml` - Verifies generated workflows match CUE definitions

All workflows are generated from CUE definitions in `cicd/`. See `cicd/README.md` for details.

## Important Notes

- **GitHub Actions workflows** - Automated CI/CD runs on all PRs (build, test, validate)
- **Workflows generated from CUE** - Edit `.cue` files in `cicd/`, not YAML files directly
- **Test infrastructure** - Lua unit tests and integration tests in `tests/`
- **Plugin updates are semi-automated** - `update-plugins` commits individually
- **Flake inputs pinned** - `flake.lock` must be committed when updated
- **Custom health check system** - use `:checkhealth nobbz` not `:checkhealth`
- **Lazy loading via lz.n** - not using lazy.nvim, custom system in `lazy/init.lua`
- **Neovide supported** - GUI wrapper defined in `nvide.nix`
- **direnv integration** - `.envrc` auto-loads dev shell if direnv installed

## Trust These Instructions

These instructions are comprehensive. Only search the codebase if information is incomplete or appears incorrect. The structure is simple and well-organized - most changes involve editing files in `plugins/nobbz/lua/nobbz/` and running `nix fmt` then `nix build`.