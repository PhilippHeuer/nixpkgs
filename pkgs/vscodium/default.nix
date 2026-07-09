{
  lib,
  stdenv,
  buildVscode,
  fetchurl,
  nix-update-script,
  commandLineArgs ? "",
  useVSCodeRipgrep ? false,
}:

let
  base = buildVscode rec {
    # renovate: datasource=github-releases depName=VSCodium/vscodium
    pname = "vscodium";
    version = "1.126.04524";
    vscodeVersion = "1.126.0";

    executableName = "codium";
    longName = "VSCodium";
    shortName = "vscodium";

    src = fetchurl {
      url = "https://github.com/VSCodium/vscodium/releases/download/${version}/VSCodium-linux-x64-${version}.tar.gz";
      hash = "sha256-rfNUjfBV0Y5HbN7oh0iLp0hrh5rZmjGlRsa1xf8pbCQ=";
    };

    sourceRoot = ".";

    inherit commandLineArgs useVSCodeRipgrep;

    updateScript = nix-update-script { };
    tests = [ ];

    meta = with lib; {
      description = "Open source binary distributions of VS Code without MS branding/telemetry/licensing";
      homepage = "https://github.com/VSCodium/vscodium";
      downloadPage = "https://github.com/VSCodium/vscodium/releases";
      changelog = "https://github.com/VSCodium/vscodium/releases/tag/${version}";
      license = licenses.mit;
      sourceProvenance = with sourceTypes; [ binaryNativeCode ];
      maintainers = with maintainers; [ ];
      mainProgram = "codium";
      platforms = [ "x86_64-linux" ];
    };
  };
in
base.overrideAttrs (old: {
  postPatch = "";
})
