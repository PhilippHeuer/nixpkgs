{
  lib,
  installShellFiles,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=cidverse/repoanalyzer
  pname = "repoanalyzer";
  version = "v0.2.0";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "repoanalyzer";
    rev = "fbea1a562383817552ff6c590547c34d2ff00613";
    sha256 = "sha256-D1Yc1Wml6T8CprSTXTVM3aFcbqjtfBipSJboE1HFJEI=";
  };
  vendorHash = "sha256-6RpXPtx1uuR2DyJg033EipEElQFwoQSNEoPaytyKCl8=";

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
    installShellCompletion --cmd repoanalyzer \
      --bash <($out/bin/repoanalyzer completion bash) \
      --fish <($out/bin/repoanalyzer completion fish) \
      --zsh  <($out/bin/repoanalyzer completion zsh)
  '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/cidverse/repoanalyzer";
    description = "repoanalyzer";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "repoanalyzer";
  };
}
