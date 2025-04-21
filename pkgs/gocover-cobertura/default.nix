{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
, buildGo123Module
}:

buildGo123Module rec {
  # renovate: datasource=github-releases depName=boumenot/gocover-cobertura
  pname = "gocover-cobertura";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "boumenot";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-nbwqfObU1tod5gWa9UbhmS6CpLLilvFyvNJ6XjeR8Qc=";
  };
  vendorHash = null;

  patches = [
    ./input-output.patch
  ];

  ldflags = [
    "-s"
    "-w"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  # metadata
  meta = with lib; {
    homepage = "https://github.com/boumenot/gocover-cobertura";
    description = "This is a simple helper tool for generating XML output in Cobertura format for CIs like Jenkins and others from go tool cover output";
    mainProgram = "gocover-cobertura";
    license = licenses.mit;
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [
      fromSource
    ];
    maintainers = with maintainers; [ ];
  };
}
