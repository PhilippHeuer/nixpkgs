{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=cidverse/reposync
  pname = "reposync";
  version = "v0.4.3";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "reposync";
    rev = version;
    sha256 = "sha256-DwS1obr8bbPEXpaHSNlJCx4+xUxb3Yvj7L0NAav/d0E=";
  };
  vendorHash = "sha256-4MTjfaF45nvRBU/j4jw/jWuOcXnUYtYi5LLsxic5HP8=";

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
