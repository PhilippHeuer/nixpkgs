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
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen";
    rev = "ad667a5217febb4ad09383e843ccdf145d32b6b1";
    sha256 = "sha256-yyabUCmwvJ22NakHfqLSXmBI/vYI2IGhMMxpUB43WMQ=";
  };
  vendorHash = "sha256-HE+sXXzy7eNf5yS/r5S6cFpMNX87Gp64aoKHzi+B6y8=";

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
