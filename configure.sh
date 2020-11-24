#!/bin/sh

cp configuration.nix /etc/nixos/
nixos-rebuild switch

