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
    rev = "076fc08445d9a72acfb296c5f535b12170132b49"; # version
    sha256 = "sha256-JecHm/TU9nzRS/b9MAK/+6kU+mlGe7E+crzsYoi6oho=";
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
