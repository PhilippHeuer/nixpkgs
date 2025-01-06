{
  lib,
  stdenv,
  fetchzip,
}:

let
  pname = "fossa-cli";
  version = "3.9.42";

  src = fetchzip {
    url = "https://github.com/fossas/fossa-cli/releases/download/v${version}/fossa_${version}_linux_amd64.zip";
    sha256 = "sha256-tfNswc7rmineN5i4H+rQNuHp7954U9HV6/Y5WN9TJTE=";
    stripRoot = false;
  };
in
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp fossa $out/bin/fossa-cli
    chmod +x $out/bin/fossa-cli

    runHook postInstall
  '';

  # disable checks
  doCheck = false;

  # metadata
  meta = with lib; {
    homepage = "https://github.com/fossas/fossa-cli";
    description = "CLI tool for software composition analysis and license compliance.";
    license = licenses.cpal10;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ]; # Add maintainers if any.
  };
}
