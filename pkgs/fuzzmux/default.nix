{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "fuzzmux";
  version = "v0.5.1";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "fuzzmux";
    rev = "d4d5fa37dc339fee6d6d6cdcb6e165763ccbbaa1";
    sha256 = "sha256-lDXVSsS9IT3eo7RehR4kQoUSg6DMXSlIbakcB997DfU=";
  };
  vendorHash = "sha256-+qWRKe4VkZCc4WabSXQzFQvyHRxXgdLBtauE5Yiw22M=";

  ldflags = [
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
    maintainers = with maintainers; [ ];
    mainProgram = "tmx";
  };
}
