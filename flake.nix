{
  description = "NixOS Packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

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
      cid = prev.callPackage ./pkgs/cid {};
      dotfiles = prev.callPackage ./pkgs/dotfiles {};
      fuzzmux = prev.callPackage ./pkgs/fuzzmux {};
      reposync = prev.callPackage ./pkgs/reposync {};
      driveguard = prev.callPackage ./pkgs/driveguard {};
      clipboard-sync = prev.callPackage ./pkgs/clipboard-sync {};
    };

    packages = genSystems (system: self.overlays.default null pkgsFor.${system});
  };
}
