# Copilot Onboarding Instructions for `nobbz-vim`

## Copilot Permissions

**Copilot is restricted to read-only access on this repository.**

Copilot MAY:
- Read any file in the repository
- Discuss, review, and analyse the codebase
- Suggest changes and explain their rationale

Copilot MAY NOT:
- Modify, create, or delete any project files

The only files Copilot is permitted to write are agent/LLM-specific instruction files:
- `AGENTS.md`
- `CLAUDE.md` (or any equivalent agent-specific instruction file)
- `.github/copilot-instructions.md` (this file)
- Anything under `.opencode/`

## Repository Overview

This is a Neovim configuration managed as a Nix flake. The repository provides a reproducible, declarative Neovim setup with custom plugins and LSP configurations.

**Key Facts:**
- **Purpose:** Personal Neovim configuration using Nix flakes for reproducibility
- **Size:** Small (~600KB, ~1900 lines of Nix/Lua code)
- **Languages:** Nix, Lua, Python (for build scripts)
- **Target Users:** Developers in the Nix ecosystem
- **Try it:** `nix run github:nobbz/nobbz-vim` (requires Nix with flakes enabled)

## Build and Development Commands

> **Reference only.** Copilot must not run these commands or modify project files.

**Prerequisites:** Nix with flakes enabled. This project REQUIRES Nix - all build/test commands use Nix.

### Core Commands (all require Nix)

1. **Build the package:** `nix build` or `nix build .#nobbzvim`
   - Builds the Neovim configuration with all plugins
   - Output in `./result` symlink
   - Takes 1-2 minutes on first build (downloads dependencies)

2. **Run directly:** `nix run` or `nix run .#nobbzvim`
   - Launches Neovim with the configuration
   - Useful for quick testing

3. **Enter dev shell:** `nix develop`
   - Provides: `nil`, `stylua`, `npins`, `alejandra`, `basedpyright`, `emmy-lua-code-style`
   - Creates `.luarc.json` symlink for LSP support
   - Use this for making changes to Lua code

4. **Format code:** `nix fmt`
   - Formats all Nix files with `alejandra`
   - Formats all Lua files with `emmy-lua-code-style` (CodeFormat)
   - **ALWAYS run before committing** - formatting is strict
   - Respects `.editorconfig`
   - Note: `stylua` is available in the dev shell as a standalone tool but is **not** part of `nix fmt`

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
   - Checks `add-plugin` and `update-plugins` packages build successfully

### Common Workflows

> **Reference only.** Copilot must not perform these steps.

**Making changes to Lua configuration:**
1. `nix develop` - enter dev shell
2. Edit files in `plugins/nobbz/lua/nobbz/`
3. Test with `:checkhealth nobbz` in Neovim
4. `nix fmt` - format before committing

**Adding a new plugin:**
1. `nix run .#add-plugin <name> <owner/repo>`
2. Edit `nix/mnw/default.nix` - add plugin to `plugins.start` list (mandatory) or `plugins.opt` list (optional)
3. Configure in `plugins/nobbz/lua/nobbz/` - create new file or edit existing
4. Add lazy loading spec if optional plugin
5. `nix build` - verify it builds
6. `nix fmt` - format before committing

## Project Structure

### Root Files
- `flake.nix` - Main flake definition, defines packages and dev shell
- `flake.lock` - Lock file for flake inputs (auto-generated, commit changes)
- `nix/mnw/default.nix` - MNW (Minimal Neovim Wrapper) configuration for Neovim package
- `nix/mnw.nix` - MNW integration module, defines `nobbzvim` and `nobbzvide` packages
- `.editorconfig` - Lua formatting rules (2 spaces, double quotes, comma separators)
- `.stylua.toml` - Stylua configuration (mostly defaults explicitly set)
- `.envrc` - direnv configuration for automatic dev shell loading
- `.gitignore` - Ignores `.luarc.json` (generated) and `.direnv`

### Directories

**`plugins/`** - Plugin management
- `default.nix` - Flake-parts module, builds vim plugins from npins entries with `nvim-` prefix
- `nobbz/` - Custom plugin containing all configuration
  - `lua/nobbz/` - Lua configuration modules
  - `plugin/nobbz.lua` - Plugin entry point

**`plugins/nobbz/lua/nobbz/`** - Configuration modules (one file per feature)
- `init.lua` - Main entry point, loads all submodules
- `lazy/` - Custom lazy-loading system wrapping `lz.n` (`init.lua`, `specs.lua`)
- `lsp/` - LSP server configurations (one file per language)
- `health.lua` - Custom health check system
- Feature-specific files: `blink.lua`, `telescope.lua`, `lualine.lua`, etc.

**`nix/`** - Nix modules
- `mnw.nix` - Defines `nobbzvim` and `nobbzvide` packages via MNW and wrapper-manager
- `mnw/default.nix` - MNW configuration: plugin lists (`plugins.start`, `plugins.opt`), LSP binaries via `extraBinPath`

**`bin/`** - Utility scripts
- `default.nix` - Flake-parts module, exposes scripts as packages
- `add-plugin.py` / `add-plugin.nix` - Script to add plugins via npins
- `update-plugins.py` / `update-plugins.nix` - Script to update all plugins

**`npins/`** - Dependency pinning
- `sources.json` - Pinned sources (plugins and dependencies)
- `default.nix` - npins library (auto-generated, don't edit)

**`pkgs/`** - Custom packages
- `oxide.nix` - Builds markdown-oxide LSP from pinned source

**`.github/`** - GitHub configuration
- `copilot-instructions.md` - This file
- No CI workflows defined (validation is manual via `nix build`)

**`.opencode/`** - OpenCode agent configuration

### Key Configuration Files

**Lua style requirements:**
- Use `local` for all variables
- Use lazy loading via `nobbz.lazy` when possible
- Follow luarocks style guide with 2-space indentation
- Double quotes for strings
- Trailing commas in tables
- Always use call parentheses
- Formatting enforced via `emmy-lua-code-style` (run through `nix fmt`)

**Nix style requirements:**
- Clear distinction between flake-parts modules and package definitions
- Plugin organisation in `nix/mnw/default.nix`:
  - Mandatory plugins in `plugins.start` list
  - Optional plugins in `plugins.opt` list
  - First section of `plugins.start` marked for revision with comment

## Common Pitfalls and Solutions

1. **Nix not available:** This project REQUIRES Nix. All operations fail without it. Do not attempt workarounds.

2. **Build failures after adding plugins:**
   - Check `nix/mnw/default.nix` - plugin must be in `plugins.start` or `plugins.opt` list
   - Verify plugin exists in `npins/sources.json` with `nvim-` prefix

3. **Lua formatting fails:**
   - Run `nix develop` first to ensure tools are available
   - Check `.editorconfig` is respected
   - `emmy-lua-code-style` must pass (run via `nix fmt`); `stylua` is available in the dev shell as a standalone tool

4. **Plugin not loading:**
   - Check `nix/mnw/default.nix` - mandatory plugins in `plugins.start`, optional in `plugins.opt`
   - If optional, must have lazy loading spec in Lua config
   - Verify in Neovim with `:checkhealth nobbz`

5. **LSP not working:**
   - LSP binaries added to PATH in `nix/mnw/default.nix` via `extraBinPath`
   - Register LSP with `require("nobbz.health").register_lsp("lsp-name")`

## Validation Steps

Before submitting changes:

1. **Format:** `nix fmt` (REQUIRED - catches style issues)
2. **Build:** `nix build` (verifies Nix evaluation and package builds)
3. **Test run:** `nix run` (launches Neovim to verify it works)
4. **Check health:** In Neovim, run `:checkhealth nobbz` (verifies programs and LSP configs)
5. **Flake check:** `nix flake check` (validates flake structure)

**No automated CI/CD** - all validation is manual. The maintainer runs these commands before merging.

## Important Notes

- **No GitHub Actions workflows** - validation is entirely manual
- **Plugin updates are semi-automated** - `update-plugins` commits individually
- **Flake inputs pinned** - `flake.lock` must be committed when updated
- **Custom health check system** - use `:checkhealth nobbz` not `:checkhealth`
- **Lazy loading via lz.n** - not using lazy.nvim, custom wrapper in `plugins/nobbz/lua/nobbz/lazy/init.lua`
- **Neovide supported** - GUI wrapper (`nobbzvide`) defined in `nix/mnw.nix`
- **direnv integration** - `.envrc` auto-loads dev shell if direnv installed

## About These Instructions

These instructions reflect the current project structure and are maintained as an agent/LLM instruction file. Copilot's role is to read, review, and discuss — not to modify project files. If information appears incomplete or incorrect, flag it rather than acting on assumptions.
