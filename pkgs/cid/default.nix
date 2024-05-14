{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "cid";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "cid";
    rev = "71574ddd6cd05f7b9592706642f931d262f9121c"; # version
    sha256 = "sha256-1ZZpqCYvzu+8EPFVu9KtZaprz2p183EuNxBjp2zR2RM=";
  };
  vendorHash = "sha256-51MQSEz1YcO5079wH7d22SG16+XQQkdi3e/EKYhzf2g=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
    "-X main.CommitHash=none"
    "-X main.RepositoryStatus=clean"
    "-X main.BuildAt=none"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  # completions
  postInstall = ''
      # install shell completion
      installShellCompletion --cmd cid \
        --bash <($out/bin/cid completion bash) \
        --fish <($out/bin/cid completion fish) \
        --zsh  <($out/bin/cid completion zsh)
    '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/cidverse/cid";
    description = "cid cli";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "cid";
  };
}
