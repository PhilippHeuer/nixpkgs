{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
, buildGo123Module
}:

buildGo123Module rec {
  pname = "fuzzmux";
  version = "v0.8.0";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "fuzzmux";
    rev = "5698dca39e49118d6c15cd223e4c9d9ba61a5c1c";
    sha256 = "sha256-nHXF3smeKljuakWz5gskCg1B70KpYTZXlkG38tBIPzU=";
  };
  vendorHash = "sha256-mxsVEu8Jby9I7zTLtl33Fp8VsQBHWKMA6kC5FiQcox4=";

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
