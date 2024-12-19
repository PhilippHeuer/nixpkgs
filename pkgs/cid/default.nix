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
    rev = "386b165b031e7d96d35c61a96f7c8b09f1080708";
    sha256 = "sha256-JRPhKp+keuILtxPLboAnapf6tmCIcQ3HDbTTdEnwN9w=";
  };
  vendorHash = "sha256-RLeK3ZWf4dtHHJBXu4RyBF8vk02nLfHTQjzmSoAsgAY=";

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
