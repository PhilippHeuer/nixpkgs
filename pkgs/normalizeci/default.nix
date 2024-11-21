{
  lib,
  installShellFiles,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=cidverse/normalizeci
  pname = "normalizeci";
  version = "v2.0.0-beta.3";

  src = fetchFromGitHub {
    owner = "cidverse";
    repo = "normalizeci";
    rev = version;
    sha256 = "sha256-R1DMAT2TwBAob1Nj1TS2mvCHy1AUhqftK8X7a0T4uzg=";
  };
  vendorHash = "sha256-v5As2L9mTHUp2hkS6Sp2P++qdc8Gc2WzfJPtJRAmBbM=";

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
    installShellCompletion --cmd normalizeci \
      --bash <($out/bin/normalizeci completion bash) \
      --fish <($out/bin/normalizeci completion fish) \
      --zsh  <($out/bin/normalizeci completion zsh)
  '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/cidverse/normalizeci";
    description = "normalizeci";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "normalizeci";
  };
}
