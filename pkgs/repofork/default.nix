{
  lib,
  stdenv,
  installShellFiles,
  fetchFromGitHub,
  buildGoModule,
  buildGo124Module,
}:

buildGo124Module rec {
  # renovate: datasource=github-releases depName=cidverse/repofork
  pname = "repofork";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "repofork";
    rev = "3ba9112c16400aec94de48a424a44c29aa39a947";
    sha256 = "sha256-jVdTpBffWDr4i+toJEt2y7e+u2LgaqACln4B4PUcFgY=";
  };
  vendorHash = "sha256-2xsMEW5hT6RXtoakC7ux4M7aRyTA8SGJZWthxMYcEB8=";

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
    installShellCompletion --cmd tmx \
      --bash <($out/bin/repofork completion bash) \
      --fish <($out/bin/repofork completion fish) \
      --zsh  <($out/bin/repofork completion zsh)
  '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/cidverse/repofork";
    description = "fuzzmux";
    license = licenses.mit;
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [
      fromSource
    ];
    maintainers = with maintainers; [ ];
    mainProgram = "repofork";
  };
}
