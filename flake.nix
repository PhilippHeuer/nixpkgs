{
  description = "NixOS Packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    genSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
    pkgsFor = nixpkgs.legacyPackages;
  in {
    overlays.default = _: prev: {
      dotfiles = prev.callPackage ./pkgs/dotfiles {};
      fuzzmux = prev.callPackage ./pkgs/fuzzmux {};
      reposync = prev.callPackage ./pkgs/reposync {};
      driveguard = prev.callPackage ./pkgs/driveguard {};
    };

    packages = genSystems (system: self.overlays.default null pkgsFor.${system});
  };
}
