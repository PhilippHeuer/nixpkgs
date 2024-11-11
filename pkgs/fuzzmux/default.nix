{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
, buildGo123Module
}:

buildGo123Module rec {
  pname = "fuzzmux";
  version = "v0.8.1";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "fuzzmux";
    rev = version;
    sha256 = "sha256-wzQGHtmxR4IJ9bny72JotgW/GEs3ESArdNdYcEbkgAo=";
  };
  vendorHash = "sha256-wdDpaohab6OCm5yDTg5M5WyVJM/9SRSfrz3XE8AQado=";

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
