import argparse
import subprocess
from typing import cast

parser = argparse.ArgumentParser(
    prog="add-plugin",
    description="Add a new plugin to the flake")

_ = parser.add_argument("-b", "--branch",
                        default=None,
                        dest='branch',
                        help="the name of the branch to use (if any)")
_ = parser.add_argument("-t", "--type",
                        default="github",
                        choices=["github", "gitlab"],
                        dest='type',
                        help="the type of the repository")
_ = parser.add_argument("name",
                        help="the name of the plugin")
_ = parser.add_argument("source",
                        help="the name of the repository")


def main():
    # type: ignore
    args = parser.parse_args()
    owner: str
    repo: str
    owner, repo = cast(str, args.source).split("/")

    command = [
        "npins",
        "add",
        "--name",
        f"nvim-{cast(str, args.name)}",
        cast(str, args.type),
        owner,
        repo,
    ]

    branch = cast(str | None, args.branch)
    if branch is not None:
        command.append("-b")
        command.append(branch)

    _ = subprocess.run(command)


if __name__ == "__main__":
    main()
