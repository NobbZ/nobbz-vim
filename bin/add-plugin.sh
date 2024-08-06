#!/usr/bin/env bash

set -ex

branch=""
name=""
repo_info=""
repo_type="github"

while getopts ":b:t:" opt; do
  case ${opt} in
    "b") branch="${OPTARG}";;
    "t") repo_type="${OPTARG}";;
    "?")
      printf "Invalid option: -%s" "${OPTARG}\n" 1>&2
      exit 1;;
  esac
done
shift $((OPTIND - 1))

name=$1
repo_info=$2

case $repo_info in
  */*)
    mapfile -t infos < <(echo "$repo_info" | tr "/" "\n")
    owner=${infos[0]}
    repo=${infos[1]}
    ;;
  *) exit 1;;
esac

if [ -z "$branch" ]; then
  npins add --name nvim-"$name" "$repo_type" "$owner" "$repo"
else
  npins add --name nvim-"$name" "$repo_type" "$owner" "$repo" -b "$branch"
fi
