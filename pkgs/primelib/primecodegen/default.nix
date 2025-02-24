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
    rev = "2f3c71f107306111fd41605f8b1e68afcf8eb21c"; # version
    sha256 = "sha256-3TDtvXS/ATpqANl60+evtqcp8gODnB8d60KCb6DMiys=";
  };
  vendorHash = "sha256-32kR6hkb588zA52bwBsjek2/YESJgKKVm2bOgkVr/fU=";

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
