{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
, nix-update-script
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=cidverse/ocisync
  pname = "ocisync";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "ocisync";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-hNSZMsZatdFAu6HAH2yrHvksHPyqCgupd0JKm1U6AGA=";
  };
  vendorHash = "sha256-8pBMxq5Ggfhgz+//dqrrv6qbpt5uDCVnbqpcgiWv9G8=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
    "-X main.CommitHash=none"
    "-X main.RepositoryStatus=clean"
    "-X main.BuildAt=none"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  passthru = {
    updateScript = nix-update-script { };
  };

  # metadata
  meta = with lib; {
    homepage = "https://github.com/cidverse/ocisync";
    description = "ocisync";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "ocisync";
  };
}
