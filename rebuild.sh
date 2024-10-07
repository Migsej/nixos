#!/usr/bin/env bash
sudo nixos-rebuild switch

echo "Do you Want to commit this change (Y/N"

read -r response

if [[ "$response" == "Y" ]]; then
  git -C ~/nixos add .
  git -C ~/nixos commit -m "$(date)"
  git -C ~/nixos push -u origin main
fi

