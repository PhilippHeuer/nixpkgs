#! /usr/bin/env nix-shell
#! nix-shell -i bash -p nix-update

set -e

# my
nix-update --commit primecodegen
nix-update --commit reposync

# others
nix-update --commit krakend-ce
nix-update --commit openapi-changes
nix-update --commit vacuum
nix-update --commit oasdiff
nix-update --commit printing-press
