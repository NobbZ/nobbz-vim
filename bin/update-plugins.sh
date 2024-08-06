#/usr/bin/env bash

pins="$(pwd)"/npins/sources.json

plugins=($(jq -rS '.pins | keys[] | select(startswith("nvim-"))' "$pins"))

for p in ${plugins[@]}; do
  printf 'updating "%s"\n' "$p"
  npins update "$p"
  echo $?
  git add "$pins"
  git commit -m "$p: update"
done
