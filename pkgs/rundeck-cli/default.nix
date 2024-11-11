{
  lib,
  stdenv,
  installShellFiles,
  openjdk21,
  stripJavaArchivesHook,
  fetchzip,
}:

let
  pname = "rundeck-cli";
  version = "2.0.8";

  src = fetchzip {
    url = "https://github.com/rundeck/rundeck-cli/releases/download/v${version}/rd-${version}.zip";
    sha256 = "sha256-+yAQ+fciYUAknMyVJkqqcLh/hf8yiuczA8t7E07bPXk=";
    stripRoot = true;
  };

in
stdenv.mkDerivation (finalAttrs: {
  inherit pname version src;

  nativeBuildInputs = [
    openjdk21
    installShellFiles
    stripJavaArchivesHook
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp -R $src/bin $out/bin
    cp -R $src/lib $out/lib

    runHook postInstall
  '';

  # disable checks
  doCheck = false;

  # metadata
  meta = with lib; {
    homepage = "https://github.com/rundeck/rundeck-cli";
    description = "CLI tool for Rundeck";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "rd";
  };
})
