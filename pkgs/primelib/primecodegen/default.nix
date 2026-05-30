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
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "primelib";
    repo = "primecodegen";
    rev = "fcc601075a21c6c6737bbb62443c0c83d7f0b8e1";
    sha256 = "sha256-YKrJs3yCF2K7YILrg/7E8UhnCB4/EUPa5BkMM6tPsXk=";
  };
  vendorHash = "sha256-56oqFy0PyXMA5FQTQpMhW2lv+j5aklHiQZ6nx8tt7WE=";

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
