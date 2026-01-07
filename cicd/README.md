# CI/CD Configuration

This directory contains CUE definitions for GitHub Actions workflows.
Workflows are generated from these definitions to ensure consistency and type safety.

## Structure

- `workflows.cue` - Base workflow definitions with common steps and jobs
- `pull-check.cue` - Pull request check workflow
- `check-generated.cue` - Workflow to verify generated files are up-to-date

## Generating Workflows

Workflows are generated using the CUE language. To regenerate workflows:

```bash
# Generate all workflows
make workflows

# Verify generated workflows match CUE definitions
make check

# Format CUE files
make fmt
```

## Generated Files

The following files are generated from CUE definitions:
- `.github/workflows/pull-check.yml`
- `.github/workflows/check-generated.yml`

**Important**: These files are committed to the repository but should not be edited directly.
Always edit the CUE definitions and regenerate.

## Workflow Overview

### Pull Request Checker (`pull-check.yml`)

Runs on every pull request:
- **build_flake** - Builds the neovim package
- **build_checks** - Runs `nix flake check`
- **lua_tests** - Runs Lua unit tests
- **integration_tests** - Runs integration tests with nvim

### Check Generated Files (`check-generated.yml`)

Verifies that generated workflows match their CUE definitions.
This ensures developers don't forget to regenerate workflows after editing CUE files.

## Adding a New Workflow

1. Create a new `.cue` file in this directory
2. Define the workflow using the `githubactions.#Workflow` schema
3. Add the workflow to the `workflows` map with a unique key
4. Update the Makefile to generate and check the new workflow
5. Run `make workflows` to generate the YAML file
6. Commit both the CUE and generated YAML files

## CUE Language

CUE is a data validation and configuration language. Learn more at:
- [CUE Language Specification](https://cuelang.org/docs/)
- [GitHub Actions Schema](https://pkg.go.dev/cue.dev/x/githubactions)

## Common Patterns

### Reusing Steps

Define common steps as private fields (starting with `_`) in `workflows.cue`:

```cue
_myStep: githubactions.#Step & {
  name: "My Step"
  run: "echo 'Hello'"
}
```

Then reference them in workflows:

```cue
jobs: my_job: {
  steps: [
    _myStep,
    // other steps...
  ]
}
```

### Conditional Steps

Use CUE's conditional expressions:

```cue
steps: [
  if someCondition { _stepA },
  _stepB,
]
```
