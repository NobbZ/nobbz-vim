import argparse
import subprocess
import os
import json

parser = argparse.ArgumentParser(
    prog="update-plugins",
    description="Update all plugins in the flake")


LOCAL_PINS = "npins/sources.json"
PINS = os.path.join(os.getcwd(), LOCAL_PINS)


def main():
    parser.parse_args()
    plugins = []

    with open(PINS, "r") as f:
        sources = json.load(f)
        plugins = [p for p in sources["pins"] if p.startswith("nvim-")]

    for p in plugins:
        print(f"updating {p}")
        subprocess.run(["npins", "update", p])
        changed_files = subprocess \
            .run(["git", "diff", "--name-only"]) \
            .stdout.decode("utf-8") \
            .strip() \
            .splitlines()
        if LOCAL_PINS in changed_files:
            subprocess.run(["git", "add", PINS])
            subprocess.run(["git", "commit", "-m", f"{p}: update"])
        else:
            print(f"No updates for {p}, skipping")


if __name__ == "__main__":
    main()
