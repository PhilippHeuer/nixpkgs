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
    rev = "23240760eef7444e77fc30edd85ad367c30f6790";
    sha256 = "sha256-Z8I100wLAsR8oPhTALWkBDnS5Hi0dISq9ZfHCHkyYPA=";
  };
  vendorHash = "sha256-BwTQ0GwAmApSTcsHSmjx/srfVoGV1rqV/32bKVps9qk=";

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
