import argparse
import subprocess

parser = argparse.ArgumentParser(
    prog="add-plugin",
    description="Add a new plugin to the flake")

parser.add_argument("-b", "--branch",
                    default=None,
                    dest='branch',
                    help="the name of the branch to use (if any)")
parser.add_argument("-t", "--type",
                    default="github",
                    choices=["github", "gitlab"],
                    dest='type',
                    help="the type of the repository")
parser.add_argument("name",
                    help="the name of the plugin")
parser.add_argument("source",
                    help="the name of the repository")


def main():
    args = parser.parse_args()
    [owner, repo] = args.source.split("/")

    command = [
        "npins",
        "add",
        "--name",
        f"nvim-{args.name}",
        args.type,
        owner,
        repo,
    ]

    if args.branch is not None:
        command.append("-b")
        command.append(args.branch)

    subprocess.run(command)


if __name__ == "__main__":
    main()
