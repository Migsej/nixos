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
  if [ -f flake.nix ]; then
    export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS develop"
    nix develop
  else
    export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS shell.nix"
    nix-shell
  fi
else
  export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS $combined"
  nix-shell -p $@
fi

