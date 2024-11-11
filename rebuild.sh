#!/usr/bin/env bash
sudo nixos-rebuild switch


git -C ~/nixos diff
echo "Do you Want to commit this change (y/n)"

read -r response

if [[ "$response" == "y" ]]; then
  git -C ~/nixos add .
  git -C ~/nixos commit -m "$(date)"
  git -C ~/nixos push -u origin main
fi

