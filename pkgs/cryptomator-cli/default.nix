{
  lib,
  stdenv,
  fetchzip,
}:

let
  pname = "cryptomator-cli";
  version = "0.6.1";

  src = fetchzip {
    url = "https://github.com/cryptomator/cli/releases/download/${version}/cryptomator-cli-${version}-linux-x64.zip";
    sha256 = "sha256-0GQfUXbiXSBLYtbDmWPJSmV7oo8D456ZDgPXc7Kgdcg=";
    stripRoot = true;
  };
in
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib
    cp -R cryptomator-cli/bin/* $out/bin
    cp -R cryptomator-cli/lib/* $out/lib
    chmod +x $out/bin/cryptomator-cli

    runHook postInstall
  '';

  # disable checks
  doCheck = false;

  # metadata
  meta = with lib; {
    homepage = "https://github.com/cryptomator/cli";
    description = "Cryptomator Command-Line Interface ";
    #license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ]; # Add maintainers if any.
  };
}
