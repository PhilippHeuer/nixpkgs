{
  lib,
  stdenv,
  installShellFiles,
  fetchFromGitHub,
  buildGoModule,
  buildGo124Module,
}:

buildGo124Module rec {
  # renovate: datasource=github-releases depName=philippheuer/fuzzmux
  pname = "fuzzmux";
  version = "v0.10.2";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "fuzzmux";
    rev = version;
    sha256 = "sha256-t7+j2g/ydxVcECw/pHGEdNxcxilMCxEiD3bVF6sA60w=";
  };
  vendorHash = "sha256-fUXkpeOR0W/Sqh5OpV2xM2KDsohexeDbkGopecfV5eY=";

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
    # rename binary
    mv $out/bin/* $out/bin/tmx

    # install shell completion
    installShellCompletion --cmd tmx \
      --bash <($out/bin/tmx completion bash) \
      --fish <($out/bin/tmx completion fish) \
      --zsh  <($out/bin/tmx completion zsh)
  '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/PhilippHeuer/fuzzmux";
    description = "fuzzmux";
    license = licenses.mit;
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [
      fromSource
    ];
    maintainers = with maintainers; [ ];
    mainProgram = "tmx";
  };
}
