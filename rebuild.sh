#!/usr/bin/env bash
sudo nixos-rebuild switch
git add .
git commit -m "$(date)"
git push -u origin main
