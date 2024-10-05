#!/usr/bin/env bash
sudo nixos-rebuild switch
git -C ~/nixos add .
git -C ~/nixos commit -m "$(date)"
git -C ~/nixos push -u origin main
