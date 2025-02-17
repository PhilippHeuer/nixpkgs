{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=cidverse/cid
  pname = "cid";
  version = "v0.5.0";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "cid";
    rev = "05b5ee8c8a549220e85c769e7edeff0c81ffb46f";
    sha256 = "sha256-HDmrBOIPQTAV95lDwZlLAsRC+Zu3FTiQ52SNejnlqog=";
  };
  vendorHash = "sha256-81CpM4z6dg25Tl+HUSphTdjkXhXe1q7/8+VOmtj4eT0=";

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
