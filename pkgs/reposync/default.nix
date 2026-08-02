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
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "reposync";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-WYC28/nYQFoND/5fXhpUnl4paduUKiH4gB2PBW3lAXc=";
  };
  vendorHash = "sha256-0nnLvPpnwmpB7VUs0OAo7RwAHt0aEKsGg8eTZFQpRSo=";

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
