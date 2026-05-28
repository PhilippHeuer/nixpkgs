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
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen";
    rev = "efebf2b7d9a1b0946def23507b5e5f6be4ecdf3f";
    sha256 = "sha256-S13pfVBZUDpNTr0J1jZCKw+zYhxV3TUOpDwFDz7zEgQ=";
  };
  vendorHash = "sha256-qaXqF+EK7sO7i0ZIQD/OkCpeJEvq/h0W/w2cdEZhoJI=";

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
