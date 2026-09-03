#!/usr/bin/env bash
set -euo pipefail

nvim_git_dir="$HOME/.config/nvim/pack/github/start"
dependencies_file="./dependencies.json"

mkdir -p "$nvim_git_dir"
cd "$nvim_git_dir"

jq -r '
    .dependencies
    | to_entries[]
    | [.key, .value.src, .value.rev]
    | @tsv
' "$dependencies_file" |
while IFS=$'\t' read -r name src rev; do
    if [[ -e "$name" ]]; then
        echo "exists, skipping: $name"
        continue
    fi

    ./clone.sh "$src" "$rev"
done
