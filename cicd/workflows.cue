package cicd

import "cue.dev/x/githubactions"

_nixVersion: "2.32.1"

workflows: [_]: githubactions.#Workflow & {
	jobs: [_]: "runs-on": *"ubuntu-24.04" | _
}

_cloneRepo: githubactions.#Step & {
	name: "Clone Repository"
	uses: "actions/checkout@v6"
}

_installCue: githubactions.#Step & {
	name: "Install Cue"
	uses: "cue-lang/setup-cue@v1.0.1"
	with: version: "v0.14.2"
}

_installNix: githubactions.#Step & {
	name: "Install nix"
	uses: "cachix/install-nix-action@v31"
	with: {
		extra_nix_config: """
			auto-optimise-store = true
			experimental-features = nix-command flakes
			substituters = https://cache.nixos.org/ https://nix-community.cachix.org
			trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
			"""
		install_url: "https://releases.nixos.org/nix/nix-\(_nixVersion)/install"
	}
}

_freeSpace: githubactions.#Step & {
	name: "Free diskspace"
	uses: "wimpysworld/nothing-but-nix@main"
}

_buildFlake: githubactions.#Job & {
	steps: [
		_freeSpace,
		_cloneRepo,
		_installNix,
		{
			name: "Build neovim package"
			run:  "nix build .#neovim --print-build-logs"
		},
	]
}

_buildChecks: githubactions.#Job & {
	steps: [
		_cloneRepo,
		_installNix,
		{
			name: "Run flake checks"
			run:  "nix flake check --print-build-logs"
		},
	]
}

_luaTests: githubactions.#Job & {
	steps: [
		_cloneRepo,
		_installNix,
		{
			name: "Run Lua tests"
			run:  "nix build .#checks.x86_64-linux.lua-tests --print-build-logs"
		},
	]
}

_integrationTests: githubactions.#Job & {
	steps: [
		_cloneRepo,
		_installNix,
		{
			name: "Run integration tests"
			run:  "nix build .#checks.x86_64-linux.integration-tests --print-build-logs"
		},
	]
}
