#!/usr/bin/env bash
set -euo pipefail

nvim_git_dir="$HOME/.config/nvim/pack/github/start"

mkdir -p "$nvim_git_dir"

cd "$nvim_git_dir"
./clone.sh "jiaoshijie/undotree" "02b69aed427b848c4dca483fc5e9524b6019c296"
./clone.sh "github/copilot.vim.git" "a12fd5672110c8aa7e3c8419e28c96943ca179be"

unset nvim_git_dir
