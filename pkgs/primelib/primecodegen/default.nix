{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "primecodegen";
  version = "v0.0.2";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen-cli";
    rev = "922c412d1e13089b9552dfc1d369f50f95658d14"; # version
    sha256 = "sha256-e/U5op5B7PQ89BKUtHv7GEvx5pFSz0ZrwW1tRQHOjOY=";
  };
  vendorHash = "sha256-SrbqnK3D0gyc5mdNq9fZbh0p8aeC8cO0Q3qvkyLJ2aI=";

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
