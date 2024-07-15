{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "primecodegen";
  version = "v0.0.3";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen-cli";
    rev = "0973316939e63dc428d200d72b072a4a24c7eb4b"; # version
    sha256 = "sha256-aCjRk2uOVqjgEt5g8OJHXDlXU3+fsmFbOJsn0GXCIN4=";
  };
  vendorHash = "sha256-j1HMEgc+f1oJ6+iON2mlFiifl83MwkWMwOX6jkVxyd8=";

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
