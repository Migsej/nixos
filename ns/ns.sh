#!/usr/bin/env bash

combined=""

for arg in "$@"; do
  if [ -z "$combined" ]; then
    combined="$arg"
  else
    combined="$combined+$arg"
  fi
done

export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS $combined"
nix-shell -p $@
