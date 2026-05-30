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
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen";
    rev = "d40209f82f400f01c15b0172c72e4da35e6f9d17";
    sha256 = "sha256-iXM3qDxc4tNY+FrMeZj1iVSXRaipIYGXuHyH0YgVnWY=";
  };
  vendorHash = "sha256-/HgPsk7lLy9MPsnEvP52LogQlm8ghtKs0uoVqkH8Qb4=";

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
