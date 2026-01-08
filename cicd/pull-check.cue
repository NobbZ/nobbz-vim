package cicd

import "cue.dev/x/githubactions"

workflows: pull_request: githubactions.#Workflow & {
	name: "Pull Request Checker"
	"on": pull_request: {}
	jobs: {
		build_flake:        _buildFlake
		build_checks:       _buildChecks
		lua_tests:          _luaTests
		integration_tests:  _integrationTests
	}
}
