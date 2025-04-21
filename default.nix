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
  primecodegen-app = pkgs.callPackage ./pkgs/primelib/primecodegen-app { };
  openapi-changes = pkgs.callPackage ./pkgs/pb33f/openapi-changes { };
  vacuum = pkgs.callPackage ./pkgs/pb33f/vacuum { };
  rundeck-cli = pkgs.callPackage ./pkgs/rundeck-cli { };
  rconcli = pkgs.callPackage ./pkgs/rconcli { };
  waypaper = pkgs.callPackage ./pkgs/waypaper { };
  wallpapers = pkgs.callPackage ./pkgs/wallpapers { };
  hellwal = pkgs.callPackage ./pkgs/hellwal { };
  fossa-cli = pkgs.callPackage ./pkgs/fossa-cli { };
  sarifrs = pkgs.callPackage ./pkgs/sarifrs { };
  cryptomator-cli = pkgs.callPackage ./pkgs/cryptomator-cli { };
  speakeasy = pkgs.callPackage ./pkgs/speakeasy { };
  goland-eap = pkgs.callPackage ./pkgs/jetbrains/goland-eap { };
  idea-ultimate-eap = pkgs.callPackage ./pkgs/jetbrains/idea-ultimate-eap { };
  rider-eap = pkgs.callPackage ./pkgs/jetbrains/rider-eap { };
  qodana = pkgs.callPackage ./pkgs/jetbrains/qodana { };
  gitlab-sarif-converter = pkgs.callPackage ./pkgs/gitlab-sarif-converter { };
  gocover-cobertura = pkgs.callPackage ./pkgs/gocover-cobertura { };
}
