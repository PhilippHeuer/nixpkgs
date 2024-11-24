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
    rev = "6d228fba2daf8addcfbf24452ab1e260b9d3014b"; # version
    sha256 = "sha256-wHHoQCXJbHBrUcYbT7ih0cPvlCUKgsBWW6+rVuija0E=";
  };
  vendorHash = "sha256-vDz3uMPU1ExkI78scsgihEUSEbgns6JPFOOmbmCcoEQ=";

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
