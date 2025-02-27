{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=primelib/primecodegen-cli
  pname = "primecodegen-app";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen-app";
    rev = "f7cd66a854b6d5526c9f81ac01c8454c9fc52225"; # version
    sha256 = "sha256-xYCQERGNKCUc/50dMfZBGMJY66Bc+k/GhM4OSYIFb+k=";
  };
  vendorHash = "sha256-076atOSkRxPoDpsu+6ug+k35SB5wPvsyPxa4di9A2mM=";

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

  # completions
  postInstall = ''
      # install shell completion
      installShellCompletion --cmd primecodegen-app \
        --bash <($out/bin/primecodegen-app completion bash) \
        --fish <($out/bin/primecodegen-app completion fish) \
        --zsh  <($out/bin/primecodegen-app completion zsh)
    '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/primelib/primecodegen-cli";
    description = "PrimeCodeGen is a code generator for API specifications";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "primecodegen-app";
  };
}
