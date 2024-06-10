{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "reposync";
  version = "v0.4.3";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "reposync";
    rev = "a02ea7f1848669496a45e0a464e5f96969429103"; # version
    sha256 = "sha256-A1d0EJpoqFkTCIWxFqROLrRsLbCfITlzyz5zHjsLlO8=";
  };
  vendorHash = "sha256-SBInvjsixPidTTTYTWZ8otU6uxLup3XDmcflUP03nPc=";

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
      installShellCompletion --cmd reposync \
        --bash <($out/bin/reposync completion bash) \
        --fish <($out/bin/reposync completion fish) \
        --zsh  <($out/bin/reposync completion zsh)
    '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/cidverse/reposync";
    description = "reposync";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "reposync";
  };
}
