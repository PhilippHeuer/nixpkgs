{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "fuzzmux";
  version = "v0.5.5";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "fuzzmux";
    rev = "7a9d4d40b6e195febdd6fb1737bb326071934e16";
    sha256 = "sha256-QSOQ7m/Sd9/s6FWoXFgxCedhCaUS4Z0yfvcwYrsTLXc=";
  };
  vendorHash = "sha256-jM2yzMuQpZcfg8KSTOTHE5IoakPYoJh2l2QKp75cLd8=";

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
    maintainers = with maintainers; [ ];
    mainProgram = "tmx";
  };
}
