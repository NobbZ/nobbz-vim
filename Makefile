# Makefile for generating GitHub Actions workflows from CUE definitions
#
# Prerequisites:
#   - cue (available in the dev shell: nix develop)
#   - alejandra (for formatting, available in dev shell)
#
# Usage:
#   make workflows    - Generate all workflow YAML files from CUE
#   make check        - Verify generated workflows match CUE definitions
#   make fmt          - Format all CUE and Nix files

.PHONY: workflows check fmt

workflows: .github/workflows/pull-check.yml .github/workflows/check-generated.yml

check:
	cue vet -c ./cicd/ .github/workflows/pull-check.yml -d 'workflows.pull_request'
	cue vet -c ./cicd/ .github/workflows/check-generated.yml -d 'workflows.checker'

.github/workflows/pull-check.yml: cicd/*.cue cue.mod/module.cue
	CUE_DEBUG=sortfields cue export ./cicd/ -f -e workflows.pull_request -o .github/workflows/pull-check.yml

.github/workflows/check-generated.yml: cicd/*.cue cue.mod/module.cue
	CUE_DEBUG=sortfields cue export ./cicd/ -f -e workflows.checker -o .github/workflows/check-generated.yml

fmt:
	cue fmt cicd/*.cue
	alejandra .
