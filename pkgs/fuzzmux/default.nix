{
  lib,
  stdenv,
  installShellFiles,
  fetchFromGitHub,
  buildGoModule,
  nix-update-script,
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=philippheuer/fuzzmux
  pname = "fuzzmux";
  version = "0.11.1";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "fuzzmux";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-0Wg28cg1RiBtLfuZQpu9/bWnHvva8kXE+FFJdpCDXw4=";
  };
  vendorHash = "sha256-Z3DgOjwOA9o8xNC1QHpUyc/qxzY+G8+Xl+93ybfkMoY=";

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

  passthru = {
    updateScript = nix-update-script { };
  };

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
