{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "primecodegen";
  version = "v0.0.1";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen-cli";
    rev = "085eb495d6741101c04df4db0d208e99630d284b"; # version
    sha256 = "sha256-kg6x9Yk9Rdmb5/ndM9cBgl4BanzpqsP7JbASo1HtEyA=";
  };
  vendorHash = "sha256-xsZMvdbPU1CPt+JYDgROYtUhZJ8r+yaIopLpIegiRVA=";

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
      installShellCompletion --cmd primecodegen-cli \
        --bash <($out/bin/primecodegen-cli completion bash) \
        --fish <($out/bin/primecodegen-cli completion fish) \
        --zsh  <($out/bin/primecodegen-cli completion zsh)
    '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/primelib/primecodegen-cli";
    description = "PrimeCodeGen is a code generator for API specifications";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "primecodegen";
  };
}
