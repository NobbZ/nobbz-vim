My `neovim` config
==================

This is my approach to a `neovim` configuration.

If you want to try it and are using `nix` already and have flakes enabled, you
can just run `nix run github:nobbz/nobbz-vim`, you might have to move/rename
existing configuration in `~/.config/nvim` temporarily.

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

* [@Gerg](https://github.com/Gerg-L) [nvim config](https://github.com/Gerg-L/nvim-flake)

