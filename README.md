My `neovim` config
==================

This is my approach to a `neovim` configuration.

If you want to try it and are using `nix` already and have flakes enabled, you
can just run `nix run github:nobbz/nobbz-vim`, you might have to move/rename
existing configuration in `~/.config/nvim` temporarily.

Testing
-------

This configuration includes automated tests:

* **Lua unit tests** - Test individual Lua modules
* **Integration tests** - Test nvim behavior in realistic scenarios

Run tests with:

```bash
# Run all checks (includes tests, builds, etc.)
nix flake check

# Run only Lua unit tests
nix build .#checks.x86_64-linux.lua-tests

# Run only integration tests
nix build .#checks.x86_64-linux.integration-tests
```

Tests are automatically run on pull requests via GitHub Actions workflows.
See `tests/README.md` for more information.

Workflow Generation
-------------------

GitHub Actions workflows are generated from CUE definitions in the `cicd/` directory.
This ensures type safety and consistency across workflows.

```bash
# Generate workflows from CUE definitions
make workflows

# Verify workflows match their definitions
make check

# Format CUE files
make fmt
```

See `cicd/README.md` for more information.

Update process
--------------

1. Create a branch: `git switch -c update $(date -Idate)`
2. update the flake lock: `nix flake update --commit-lock-file`
3. *optional* fix build errors
4. update plugins: `nix run .#update-plugins`
5. *optional* fix build errors
6. *optional* update these instructions 😀

Inspiration
-----------

* [@Gerg] [nvim config][gerg-config] (before he switched to [`mnw`])
* [@ViperML] [nvim config][viper-config] (lazy loading implementation, also the
  idea of having health checks)

[@Gerg]: https://github.com/Gerg-L
[@ViperML]: https://github.com/viperML
[gerg-config]: https://github.com/Gerg-L/nvim-flake
[viper-config]: https://github.com/viperML/dotfiles/tree/e43c072f8bc229a45e41978e751b47e1d3d81893/packages/neovim/viper-init-plugin
[`mnw`]: https://github.com/Gerg-L/mnw
