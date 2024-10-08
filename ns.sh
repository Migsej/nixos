#!/usr/bin/env bash

export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS $@"
nix-shell -p $@
