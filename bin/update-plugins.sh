#/usr/bin/env bash

local_pins=npins/sources.json
pins="$(pwd)/${local_pins}"

mapfile -t plugins < <(jq -rS '.pins | keys[] | select(startswith("nvim-"))' "$pins")

for p in "${plugins[@]}"; do
  printf 'updating "%s"\n' "$p"
  npins update "$p"
  if git diff --name-only | grep "${local_pins}"; then
    git add "$pins"
    git commit -m "$p: update"
  else
    printf "No updates for %s, skipping\n" "$p"
  fi
done
