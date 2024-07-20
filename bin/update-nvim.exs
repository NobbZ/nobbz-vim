#!/usr/bin/env elixir

Mix.install([
  {:jason, "~> 1.4.3"},
  {:req, "~> 0.5.4"}
])

defmodule NeovimUpdater do
  @upstream_lock "https://github.com/nix-community/neovim-nightly-overlay/raw/master/flake.lock"

  defmodule Lock do
    defstruct [:owner, :repo, :rev, :type]

    def parse(raw) do
      %{"owner" => owner, "repo" => repo, "rev" => rev, "type" => type} =
        get_in(raw, ["nodes", "neovim-src", "locked"])

      %__MODULE__{
        owner: owner,
        repo: repo,
        rev: rev,
        type: type
      }
    end
  end

  defmodule Deps do
    def fetch!(lock) do
      lock
      |> build_url()
      |> Req.get!()
      |> NeovimUpdater.get_body()
      |> then(&File.write("deps.txt", &1))
    end

    defp build_url(%{owner: owner, repo: repo, rev: rev}) do
      "https://github.com/#{owner}/#{repo}/raw/#{rev}/cmake.deps/deps.txt"
    end
  end

  def update() do
    @upstream_lock
    |> Req.get!()
    |> get_body()
    |> Jason.decode!()
    |> Lock.parse()
    |> tap(&Deps.fetch!/1)
    |> build_npins_args()
    |> run_npins()
  end

  defp build_npins_args(%{owner: owner, repo: repo, rev: rev}) do
    [
      ["remove", "neovim"],
      ["add", "--name", "neovim", "github", owner, repo, "--at", rev, "--branch", "master"]
    ]
  end

  def run_npins(args) do
    Enum.each(args, &System.cmd("npins", &1))
  end

  def get_body(%{body: body}), do: body
end

NeovimUpdater.update()
