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
    rev = "07144958355aa3b3f0cb8c3a4b14d11e5a6c158c";
    sha256 = "sha256-V0TEzqlj1FVBnEWguX1C3SjOxaIqwhGCqk6eMJc9rqc=";
  };
  vendorHash = "sha256-6pNqxHsOcHgYIsip4xtUPk+zN2GoA2HnuFVfaniqQko=";

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
