#! /usr/bin/env nix-shell
#! nix-shell -i bash -p nix-update

set -e

nix-update --commit krakend-ce
nix-update --commit openapi-changes
nix-update --commit vacuum
