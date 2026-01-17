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
workflows:
    @echo "Generating workflows from CUE definitions..."
    CUE_DEBUG=sortfields cue export ./cicd/ -f -e workflows.pull_request -o .github/workflows/pull-check.yml
    CUE_DEBUG=sortfields cue export ./cicd/ -f -e workflows.checker -o .github/workflows/check-generated.yml
    @echo "✓ Workflows generated successfully"

# Verify generated workflows match CUE definitions
check:
    @echo "Verifying generated workflows..."
    cue vet -c ./cicd/ .github/workflows/pull-check.yml -d 'workflows.pull_request'
    cue vet -c ./cicd/ .github/workflows/check-generated.yml -d 'workflows.checker'
    @echo "✓ Workflows verified successfully"

# Format all CUE and Nix files
fmt:
    @echo "Formatting CUE files..."
    cue fmt cicd/*.cue
    @echo "Formatting Nix files..."
    alejandra .
    @echo "✓ Formatting complete"
