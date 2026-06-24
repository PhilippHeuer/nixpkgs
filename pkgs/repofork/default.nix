{
  lib,
  stdenv,
  installShellFiles,
  fetchFromGitHub,
  buildGoModule,
  nix-update-script,
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=cidverse/repofork
  pname = "repofork";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "repofork";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-MnshuFXsgglkhsU+Hw6e2IGoowRmP35uLeT1qTaOcGQ=";
  };
  vendorHash = "sha256-anyzR0IwJ+U13B2VX4fR2HBbahrQax6+pnt3beIqixA=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.commit=none"
    "-X main.date=none"
    "-X main.status=clean"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  # completions
  postInstall = ''
    # install shell completion
    installShellCompletion --cmd repofork \
      --bash <($out/bin/repofork completion bash) \
      --fish <($out/bin/repofork completion fish) \
      --zsh  <($out/bin/repofork completion zsh)
  '';

  passthru = {
    updateScript = nix-update-script { };
  };

  # metadata
  meta = with lib; {
    homepage = "https://github.com/cidverse/repofork";
    description = "repofork";
    license = licenses.mit;
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [
      fromSource
    ];
    maintainers = with maintainers; [ ];
    mainProgram = "repofork";
  };
}
