#!/usr/bin/env bash

combined=""

for arg in "$@"; do
  if [ -z "$combined" ]; then
    combined="$arg"
  else
    combined="$combined+$arg"
  fi
done

if [ $# -eq 0 ]; then
  combined="shell.nix"
  export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS shell.nix"
  nix-shell
else
  export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS $combined"
  nix-shell -p $@
fi

