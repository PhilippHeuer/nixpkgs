{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "reposync";
  version = "v0.4.2";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "reposync";
    rev = "9cc537ad749f21ce27726416b78a05ae11a61637"; # version
    sha256 = "sha256-NWVC6IrEs3E0W9uvtqUUxk7nBOVreFjswEHpAkwLxQQ=";
  };
  vendorHash = "sha256-jM+urq1mVgXAynY4V+g+lFyPvFeutDkTgjuSSjnpifY=";

  ldflags = [
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
