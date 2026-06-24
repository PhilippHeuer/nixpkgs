{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
, nix-update-script
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=cidverse/reposync
  pname = "reposync";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "reposync";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-8lAGi6cUpQ428AK+EUinD3mQx6gF9NLslwioIvB6T44=";
  };
  vendorHash = "sha256-wrZvXxWDtUttmb+KvvBX9zi/UV3NfCTnhDYILwFjuZg=";

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

  passthru = {
    updateScript = nix-update-script { };
  };

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
