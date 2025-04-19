{ lib
, stdenv
, installShellFiles
, fetchFromGitLab
, buildGoModule
, buildGo123Module
}:

buildGo123Module rec {
  # renovate: datasource=gitlab-tags depName=ignis-build/sarif-converter
  pname = "gitlab-sarif-converter";
  version = "0.9.4";

  src = fetchFromGitLab {
    owner = "ignis-build";
    repo = "sarif-converter";
    rev = version;
    sha256 = "sha256-Q8L4C4mTJEfxASqrUAZlMoLx71/+nmP6mwW/vNFStTs=";
  };
  vendorHash = "sha256-vK+HhHlFWoWIrDEZzfRoqtJ3vKp0f4b8l8+LBlZuBJU=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.revision=${src.rev}"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  # completions
  postInstall = ''
      # rename binary
      mv $out/bin/* $out/bin/gitlab-sarif-converter
    '';

  # metadata
  meta = with lib; {
    homepage = "https://gitlab.com/ignis-build/sarif-converter";
    description = "Convert from SARIF to GitLab Code Quality and SAST report.";
    license = licenses.mit;
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [
      fromSource
    ];
    maintainers = with maintainers; [ ];
    mainProgram = "gitlab-sarif-converter";
  };
}
