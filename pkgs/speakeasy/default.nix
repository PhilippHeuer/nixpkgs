{
  lib,
  stdenv,
  fetchzip,
}:

let
  pname = "speakeasy";
  version = "1.509.1";

  src = fetchzip {
    url = "https://github.com/speakeasy-api/speakeasy/releases/download/v${version}/speakeasy_linux_amd64.zip";
    sha256 = "sha256-pCBHQfwoJxJ4dNULABYgnh6jg19FS8v7E4MeNeJDZ7g=";
    stripRoot = false;
  };
in
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib
    cp speakeasy $out/bin
    chmod +x $out/bin/speakeasy

    runHook postInstall
  '';

  # disable checks
  doCheck = false;

  # metadata
  meta = with lib; {
    homepage = "https://github.com/speakeasy-api/speakeasy";
    description = "Build APIs your users love ❤️ with Speakeasy.";
    #license = licenses.agpl3; // Elastic License 2.0
    platforms = platforms.linux;
    maintainers = with maintainers; [ ]; # Add maintainers if any.
  };
}
