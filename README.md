My `neovim` config
==================

This is my approach to a `neovim` configuration.

If you want to try it and are using `nix` already and have flakes enabled, you
can just run `nix run github:nobbz/nobbz-vim`, you might have to move/rename
existing configuration in `~/.config/nvim` temporarily.

Testing
-------

The configuration includes automated integration tests that can be run via:

```bash
nix flake check
```

This runs three test suites:

1. **nvim-config-loads**: Verifies the configuration loads without errors
2. **nvim-health-check**: Runs `:checkhealth nobbz` to verify all systems
3. **nvim-lua-tests**: Runs Lua-based integration tests for core functionality

Individual tests can be run with:

```bash
# Run specific test
nix build .#checks.x86_64-linux.nvim-config-loads

# View test output
cat result
```

Update process
--------------

1. Create a branch: `git switch -c update $(date -Idate)`
2. update the flake lock: `nix flake update --commit-lock-file`
3. *optional* fix build errors
4. update plugins: `nix run .#update-plugins`
5. *optional* fix build errors
6. run tests: `nix flake check`
7. *optional* update these instructions 😀

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
