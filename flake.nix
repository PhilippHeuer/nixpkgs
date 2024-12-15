{
  description = "NixOS Packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = {
    self,
    nixpkgs,
  }: let
    # System types to support.
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    # Convert supported systems into a attribute set.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Instantiate Nixpkgs for all supported systems.
    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

    pkgsFor = nixpkgs.legacyPackages;
  in {
    # Provide some binary packages for selected system types.
    packages = forAllSystems (system: {
      cid = nixpkgsFor.${system}.callPackage ./pkgs/cid {};
      dotfiles = nixpkgsFor.${system}.callPackage ./pkgs/dotfiles {};
      fuzzmux = nixpkgsFor.${system}.callPackage ./pkgs/fuzzmux {};
      reposync = nixpkgsFor.${system}.callPackage ./pkgs/reposync {};
      normalizeci = nixpkgsFor.${system}.callPackage ./pkgs/normalizeci {};
      repoanalyzer = nixpkgsFor.${system}.callPackage ./pkgs/repoanalyzer {};
      driveguard = nixpkgsFor.${system}.callPackage ./pkgs/driveguard {};
      clipboard-sync = nixpkgsFor.${system}.callPackage ./pkgs/clipboard-sync {};
      primecodegen = nixpkgsFor.${system}.callPackage ./pkgs/primelib/primecodegen {};
      openapi-changes = nixpkgsFor.${system}.callPackage ./pkgs/pb33f/openapi-changes {};
      vacuum = nixpkgsFor.${system}.callPackage ./pkgs/pb33f/vacuum {};
      rundeck-cli = nixpkgsFor.${system}.callPackage ./pkgs/rundeck-cli {};
      gocheat = nixpkgsFor.${system}.callPackage ./pkgs/gocheat {};
      rconcli = nixpkgsFor.${system}.callPackage ./pkgs/rconcli {};
      waypaper = nixpkgsFor.${system}.callPackage ./pkgs/waypaper {};
      loungy = nixpkgsFor.${system}.callPackage ./pkgs/matthiasgrandl/loungy {};
      wallpapers = nixpkgsFor.${system}.callPackage ./pkgs/wallpapers {};
      hellwal = nixpkgsFor.${system}.callPackage ./pkgs/hellwal {};
    });
  };
}
