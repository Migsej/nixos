#!/usr/bin/env bash

if [[ "$1" -eq "normal" ]]; then
  file="
{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [
    ];
}"
elif [[ "$1" -eq "python" ]]; then
  file="{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (ps: [
    ]))
  ];
}
"
fi

echo "$file" > shell.nix


