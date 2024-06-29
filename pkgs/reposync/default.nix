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
    rev = "7dbdbe126df8af0bb932e6c32749fdb5e01e8c8a"; # version
    sha256 = "sha256-o6cvRLJxUhYQDy+1P7Hak3suyu4C7D2EECIARR0o6B8=";
  };
  vendorHash = "sha256-fzjQn8CIZ4KPE6gghobIVq/JCC55UGNGr1APybZL9hk=";

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
