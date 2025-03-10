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
    repo = "primecodegen-cli";
    rev = "ef1ab707f308821414e3b0b06b6e5aff3d03683a"; # version
    sha256 = "sha256-z41Auv8ho6VlESnTy2uEnli1R+SBxgmoKabH0zMCS8Y=";
  };
  vendorHash = "sha256-3RTkUkkzWv80dw+c285Bn5t2hGLLT2n2pZnyWrYmpao=";

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
    homepage = "https://github.com/primelib/primecodegen-cli";
    description = "PrimeCodeGen is a code generator for API specifications";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "primecodegen";
  };
}
