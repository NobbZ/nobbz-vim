#!/usr/bin/env elixir

Mix.install([
  {:jason, "~> 1.4.3"},
  {:req, "~> 0.5.4"}
])

"https://github.com/nix-community/neovim-nightly-overlay/raw/master/flake.lock"
|> Req.get!()
|> then(& &1.body)
|> Jason.decode!()
|> get_in(["nodes", "neovim-src", "locked"])
|> tap(fn %{"owner" => owner, "repo" => repo, "rev" => rev} ->
  "https://github.com/#{owner}/#{repo}/raw/#{rev}/cmake.deps/deps.txt"
  |> Req.get!()
  |> then(& &1.body)
  |> then(&File.write("deps.txt", &1))
end)
|> then(fn %{"owner" => owner, "repo" => repo, "rev" => rev} ->
  [
    ["remove", "neovim"],
    ["add", "--name", "neovim", "github", owner, repo, "--at", rev, "--branch", "master"]
  ]
end)
|> Enum.each(&System.cmd("npins", &1))
