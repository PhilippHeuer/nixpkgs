#! /usr/bin/env nix-shell
#! nix-shell -i bash -p nix-update

set -e

# my
nix-update --commit fuzzmux
nix-update --commit reposync
nix-update --commit repofork
nix-update --commit ocisync
nix-update --commit primecodegen

# others
nix-update --commit krakend-ce
nix-update --commit openapi-changes
nix-update --commit vacuum
nix-update --commit oasdiff
nix-update --commit printing-press
