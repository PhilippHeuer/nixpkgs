{
  pkgs ? import <nixpkgs> { },
}:

{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  # Packages
  cid = pkgs.callPackage ./pkgs/cid { };
  dotfiles = pkgs.callPackage ./pkgs/dotfiles { };
  fuzzmux = pkgs.callPackage ./pkgs/fuzzmux { };
  reposync = pkgs.callPackage ./pkgs/reposync { };
  normalizeci = pkgs.callPackage ./pkgs/normalizeci { };
  repoanalyzer = pkgs.callPackage ./pkgs/repoanalyzer { };
  driveguard = pkgs.callPackage ./pkgs/driveguard { };
  clipboard-sync = pkgs.callPackage ./pkgs/clipboard-sync { };
  primecodegen = pkgs.callPackage ./pkgs/primelib/primecodegen { };
  openapi-changes = pkgs.callPackage ./pkgs/pb33f/openapi-changes { };
  vacuum = pkgs.callPackage ./pkgs/pb33f/vacuum { };
  rundeck-cli = pkgs.callPackage ./pkgs/rundeck-cli { };
  rconcli = pkgs.callPackage ./pkgs/rconcli { };
  ags = pkgs.callPackage ./pkgs/ags { };
  waypaper = pkgs.callPackage ./pkgs/waypaper { };
  loungy = pkgs.callPackage ./pkgs/matthiasgrandl/loungy { };
  wallpapers = pkgs.callPackage ./pkgs/wallpapers { };
  hellwal = pkgs.callPackage ./pkgs/hellwal { };
}
