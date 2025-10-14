{ lib,
  stdenv,
  jdk21_headless,
  stripJavaArchivesHook,
  fetchzip,
}:

let
  pname = "sonar-scanner-cli";
  version = "7.3.0.5189";

  src = fetchzip {
    url = "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${version}.zip";
    sha256 = "sha256-GJdrD5F9zi5XeyQRGXTs8agDULOWjFtB9OXFeFPgRFM=";
    stripRoot = true;
  };

  jdk = jdk21_headless;
in
stdenv.mkDerivation (finalAttrs: {
  inherit pname version src;

  nativeBuildInputs = [
    #stripJavaArchivesHook
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp -R $src/* $out/

    runHook postInstall
  '';

  # Disable checks
  doCheck = false;

  # Metadata
  meta = with lib; {
    homepage = "https://www.sonarqube.org/";
    description = "SonarScanner CLI tool for SonarQube";
    #license = licenses.unfree;
    platforms = jdk.meta.platforms;
    maintainers = with maintainers; [ ];
    mainProgram = "sonar-scanner";
  };
})
