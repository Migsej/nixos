#!/usr/bin/env bash

case "$1" in
  "Makefile")
    echo "creating Makefile"
    cat << EOF > Makefile
PREFIX=/usr/local
BINDIR=\$(PREFIX)/bin

all: build

build:
  cc -o main main.c

.PHONY: clean install

install:
	mkdir -p \$(BINDIR)
	cp main \$(BINDIR)

clean:
	rm -rf main
EOF
;;
  "shell.nix")
    echo "creating shell.nix" 
    cat << EOF > shell.nix
{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pygame
    ])) ];
}

EOF
;;
  "build.nix")
    echo "creating build.nix"
    cat << EOF > build.nix
{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  pname = "name";
  version = "1.0.0";

  makeFlags = ["PREFIX=\$(out)"];

  nativeBuildInputs = [
    
  ];

  src = ./.;
}
EOF
;;
  *)
    echo "unkown option $1"
esac

