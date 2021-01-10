#!/bin/sh
echo "{ hostname = \"$(hostname)\"; operatingSystem = \"$(uname -v | awk '{ print $1 }' | sed 's/#.*-//')\"; }" > ~/.config/nixpkgs/machine.nix