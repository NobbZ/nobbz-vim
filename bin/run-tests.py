#!/usr/bin/env python3
"""Test runner script for local development."""

import platform
import subprocess
import sys
from pathlib import Path


class Colors:
    """ANSI color codes."""

    RED = "\033[0;31m"
    GREEN = "\033[0;32m"
    YELLOW = "\033[1;33m"
    NC = "\033[0m"  # No Color


def print_section(text: str) -> None:
    """Print a section header."""
    print(f"\n{Colors.YELLOW}==== {text} ===={Colors.NC}\n")


def print_success(text: str) -> None:
    """Print a success message."""
    print(f"{Colors.GREEN}✓ {text}{Colors.NC}")


def print_error(text: str) -> None:
    """Print an error message."""
    print(f"{Colors.RED}✗ {text}{Colors.NC}")


def find_flake_root() -> Path | None:
    """Find the flake root by searching parent directories."""
    current = Path.cwd()
    while current != current.parent:
        if (current / "flake.nix").exists():
            return current
        current = current.parent
    return None


def detect_system() -> str:
    """Detect the current system architecture."""
    machine = platform.machine()
    system = platform.system().lower()
    
    # Map Python's machine names to Nix system names
    if system == "linux":
        if machine in ("x86_64", "AMD64"):
            return "x86_64-linux"
        elif machine in ("aarch64", "arm64"):
            return "aarch64-linux"
    elif system == "darwin":
        if machine in ("x86_64", "AMD64"):
            return "x86_64-darwin"
        elif machine in ("aarch64", "arm64"):
            return "aarch64-darwin"
    
    # Default to x86_64-linux if we can't detect
    return "x86_64-linux"


def run_command(cmd: list[str], description: str) -> bool:
    """Run a command and return success status."""
    try:
        result = subprocess.run(cmd, check=True)
        return result.returncode == 0
    except subprocess.CalledProcessError:
        return False


def main() -> int:
    """Run all tests."""
    # Find flake root
    flake_root = find_flake_root()
    if flake_root is None:
        print_error("Not in a Nix flake directory (searched parent directories)")
        return 1
    
    # Detect system
    system = detect_system()
    print(f"Detected system: {system}")

    # Build neovim package
    print_section("Building neovim package")
    if run_command(
        ["nix", "build", ".#neovim", "--print-build-logs"],
        "Building neovim package",
    ):
        print_success("Neovim package built successfully")
    else:
        print_error("Failed to build neovim package")
        return 1

    # Run Lua tests
    print_section("Running Lua tests")
    if run_command(
        ["nix", "build", f".#checks.{system}.lua-tests", "--print-build-logs"],
        "Running Lua tests",
    ):
        print_success("Lua tests passed")
    else:
        print_error("Lua tests failed")
        return 1

    # Run integration tests
    print_section("Running integration tests")
    if run_command(
        [
            "nix",
            "build",
            f".#checks.{system}.integration-tests",
            "--print-build-logs",
        ],
        "Running integration tests",
    ):
        print_success("Integration tests passed")
    else:
        print_error("Integration tests failed")
        return 1

    # Run flake checks
    print_section("Running flake checks")
    if run_command(
        ["nix", "flake", "check", "--print-build-logs"], "Running flake checks"
    ):
        print_success("Flake checks passed")
    else:
        print_error("Flake checks failed")
        return 1

    # Success
    print_section("All tests passed!")
    print(f"{Colors.GREEN}✓ All checks completed successfully{Colors.NC}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
