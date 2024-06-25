#!/usr/bin/env bash

set -ex

ranch=""
name=""
repo_info=""

while getopts ":b:" opt; do
  case ${opt} in
    "b") branch="${OPTARG}";;
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
    infos=($(echo "$repo_info" | tr "/" "\n"))
    owner=${infos[0]}
    repo=${infos[1]}
    ;;
  *) exit 1;;
esac

if [ -z $branch ]; then
  npins add --name nvim-$name github $owner $repo
else
  npins add --name nvim-$name github $owner $repo -b $branch
fi
