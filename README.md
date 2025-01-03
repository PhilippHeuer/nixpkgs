# NixPKG Registry

## Usage

Add the input to your `flake.nix`:

```nix
nixpkgs-philippheuer = {
  url = "github:philippheuer/nixpkgs/main";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

To make `inputs` available in your configurations, add the inherit to `specialArgs`:

```nix
# for Home Manager
homeConfigurations.YOURCONFIG = inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = ...;
  modules = ...;

  extraSpecialArgs = {inherit inputs;};
}

# for NixOS
nixosConfigurations.YOURHOSTNAME = inputs.nixpkgs.nixosSystem {
  system = "...";
  modules = ...;

  specialArgs = {inherit inputs;};
}
```

Add packages to your `environment.systemPackages` or `home.packages`:

```nix
{pkgs, inputs, ...}: {
  environment.systemPackages = [ # or home.packages
    inputs.nixpkgs-philippheuer.packages.${pkgs.system}.reposync # or any other package
  ];
}
```

## Packages

- `reposync` - A tool to synchronize git repositories you have access to onto your local machine
- ...

## Contribute

_build your package locally_

`nix build .#reposync`

## Credits

- [nur-packages-template](https://github.com/nix-community/nur-packages-template/tree/master)

## License

Released under the [MIT license](./LICENSE).
