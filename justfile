# Justfile for generating GitHub Actions workflows from CUE definitions
#
# Prerequisites:
#   - cue (available in the dev shell: nix develop)
#   - alejandra (for formatting, available in dev shell)
#
# Usage:
#   just workflows    - Generate all workflow YAML files from CUE
#   just check        - Verify generated workflows match CUE definitions
#   just fmt          - Format all CUE and Nix files

# Generate all workflows
workflows: pull-check-workflow check-generated-workflow

# Verify generated workflows match CUE definitions
check:
    cue vet -c ./cicd/ .github/workflows/pull-check.yml -d 'workflows.pull_request'
    cue vet -c ./cicd/ .github/workflows/check-generated.yml -d 'workflows.checker'

# Generate pull-check workflow
pull-check-workflow: cicd/*.cue cue.mod/module.cue
    CUE_DEBUG=sortfields cue export ./cicd/ -f -e workflows.pull_request -o .github/workflows/pull-check.yml

# Generate check-generated workflow
check-generated-workflow: cicd/*.cue cue.mod/module.cue
    CUE_DEBUG=sortfields cue export ./cicd/ -f -e workflows.checker -o .github/workflows/check-generated.yml

# Format all CUE and Nix files
fmt:
    cue fmt cicd/*.cue
    alejandra .
