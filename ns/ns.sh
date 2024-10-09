#!/usr/bin/env bash

combined=""

for arg in "$@"; do
  if [ -z "$combined" ]; then
    combined="$arg"
  else
    combined="$combined+$arg"
  fi
done

if [ -z "$combined" ]; then
  combined="shell.nix"
fi

export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS $combined"
nix-shell -p $@
