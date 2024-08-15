{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, fetchFromGitLab
, buildGoModule
}:

stdenv.mkDerivation rec {
  pname = "wallpapers";
  version = "c8bfeb74fec08137536a22bf7b096024a95d617f";

  dontUnpack = true;

  src = fetchFromGitLab {
    owner = "philippheuer";
    repo = "wallpapers";
    rev = version;
    sha256 = "sha256-BlvCE2In+26b6xeMWEEc1zY+pEGBfIPyZ0V0sZAvSto=";
  };

  preInstall = ''
    mkdir -p $out/share/backgrounds
  '';

  installPhase = ''
    runHook preInstall
    cp -r $src/themes/* $out/share/backgrounds
    runHook postInstall
  '';

  # metadata
  meta = with lib; {
    homepage = "https://gitlab.com/philippheuer/wallpapers";
    description = "wallpapers";
    platforms = platforms.all;
    maintainers = [ ];
  };
}
