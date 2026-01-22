import argparse
import json
import os
import subprocess
from typing import TypedDict

parser = argparse.ArgumentParser(
    prog="update-plugins", description="Update all plugins in the flake"
)


LOCAL_PINS = "npins/sources.json"
PINS = os.path.join(os.getcwd(), LOCAL_PINS)


class NpinsLock(TypedDict):
    pins: dict[str, dict[str, object]]
    version: int


def main():
    _ = parser.parse_args()
    plugins = []

    with open(PINS, "r") as f:
        sources: NpinsLock = json.load(f)
        plugins = [p for p in sources["pins"] if p.startswith("nvim-")]

    for p in plugins:
        print(f"updating {p}")
        _ = subprocess.run(["npins", "update", p])
        changed_files = (
            str(
                subprocess.check_output(
                    ["git", "diff", "--name-only"], encoding="utf-8"
                )
            )
            .strip()
            .splitlines()
        )

        if LOCAL_PINS in changed_files:
            _ = subprocess.run(["git", "add", PINS])
            _ = subprocess.run(["git", "commit", "-m", f"{p}: update"])
        else:
            print(f"No updates for {p}, skipping")


if __name__ == "__main__":
    main()
