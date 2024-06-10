{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "fuzzmux";
  version = "v0.5.4";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "fuzzmux";
    rev = "619622cc2efe4058e15b83861d56be6377b332dd";
    sha256 = "sha256-mDD3+uPqotzAQi1+bWCJzAqldSFJy65BdNtWN6BTbIY=";
  };
  vendorHash = "sha256-2UqftIgRRt7iXHAf8AjomvG8wPssLKk9ose91pFSReQ=";

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
