{
  pkgs ? import <nixpkgs> { },
}:

{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  # Packages
  appinspector = pkgs.callPackage ./pkgs/appinspector { };
  cid = pkgs.callPackage ./pkgs/cid { };
  dotfiles = pkgs.callPackage ./pkgs/dotfiles { };
  fuzzmux = pkgs.callPackage ./pkgs/fuzzmux { };
  reposync = pkgs.callPackage ./pkgs/reposync { };
  normalizeci = pkgs.callPackage ./pkgs/normalizeci { };
  repoanalyzer = pkgs.callPackage ./pkgs/repoanalyzer { };
  driveguard = pkgs.callPackage ./pkgs/driveguard { };
  clipboard-sync = pkgs.callPackage ./pkgs/clipboard-sync { };
  sonarscanner-cli = pkgs.callPackage ./pkgs/sonarscanner-cli { };
  primecodegen = pkgs.callPackage ./pkgs/primelib/primecodegen { };
  openapi-changes = pkgs.callPackage ./pkgs/pb33f/openapi-changes { };
  vacuum = pkgs.callPackage ./pkgs/pb33f/vacuum { };
  rundeck-cli = pkgs.callPackage ./pkgs/rundeck-cli { };
  rconcli = pkgs.callPackage ./pkgs/rconcli { };
  waypaper = pkgs.callPackage ./pkgs/waypaper { };
  wallpapers = pkgs.callPackage ./pkgs/wallpapers { };
  hellwal = pkgs.callPackage ./pkgs/hellwal { };
  fossa-cli = pkgs.callPackage ./pkgs/fossa-cli { };
  sarifrs = pkgs.callPackage ./pkgs/sarifrs { };
}
