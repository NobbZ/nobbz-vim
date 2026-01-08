package cicd

import "cue.dev/x/githubactions"

_nixVersion: "2.32.1"
_cueVersion: "v0.14.2"
_justVersion: "1.36.0"

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
	with: version: _cueVersion
}

_installJust: githubactions.#Step & {
	name: "Install Just"
	uses: "extractions/setup-just@v2"
	with: "just-version": _justVersion
}

_installNix: githubactions.#Step & {
	name: "Install nix"
	uses: "cachix/install-nix-action@v31"
	with: {
		extra_nix_config: """
			auto-optimise-store = true
			experimental-features = nix-command flakes
			"""
		install_url: "https://releases.nixos.org/nix/nix-\(_nixVersion)/install"
	}
}

_buildFlake: githubactions.#Job & {
	steps: [
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
