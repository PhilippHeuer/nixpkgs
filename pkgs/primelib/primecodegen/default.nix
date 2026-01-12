{
  lib,
  stdenv,
  installShellFiles,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=primelib/primecodegen
  pname = "primecodegen";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen";
    rev = "88fa01ad527bd11ca97f1a83cfbe765eb20f9e75";
    sha256 = "sha256-0bhdD8BJQs44Gum6cTz9KGABBjzzm3TNKiHx9iHGFbI=";
  };
  vendorHash = "sha256-uXa8GrCnZTMGMVppZgo/TY/yrAZe42QimeMSz7X9eAk=";

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
    installShellCompletion --cmd primecodegen \
      --bash <($out/bin/primecodegen completion bash) \
      --fish <($out/bin/primecodegen completion fish) \
      --zsh  <($out/bin/primecodegen completion zsh)
  '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/primelib/primecodegen";
    description = "PrimeCodeGen is a code generator for API specifications";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "primecodegen";
  };
}
