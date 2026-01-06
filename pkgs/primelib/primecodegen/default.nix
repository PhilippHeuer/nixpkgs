{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=primelib/primecodegen-cli
  pname = "primecodegen";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen";
    rev = "1f3160eb65ffb96436a570bff20a90085e172062"; # version
    sha256 = "sha256-oZgLONDy0Xqu4kfCr2Jwg5HSTq/bgpeMPO6Ac9AUYn8=";
  };
  vendorHash = "sha256-EXc81NKOw9f9vmWbbjQ75wqY2sDjC8suRL35+BOZNR4=";

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
