_default:
	@just -l

# tasks
update:
	nix flake update

update-packages:
    ./scripts/update.sh
