{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
, nix-update-script
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=philippheuer/dotfiles-cli
  pname = "dotfiles-cli";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "dotfiles-cli";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-EUHbF4YGDSn183g5/eV+gj/UUF2pS8ddclN4zdeEIQw=";
  };
  vendorHash = "sha256-FDAtxdJBsILCtEloxigpnyIbQKgqJFBVo3qdEETFTFc=";

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
      # rename binary
      mv $out/bin/* $out/bin/dotfiles

      # install shell completion
      installShellCompletion --cmd dotfiles \
        --bash <($out/bin/dotfiles completion bash) \
        --fish <($out/bin/dotfiles completion fish) \
        --zsh  <($out/bin/dotfiles completion zsh)
    '';

  passthru = {
    updateScript = nix-update-script { };
  };

  # metadata
  meta = with lib; {
    homepage = "https://github.com/PhilippHeuer/dotfiles-cli";
    description = "dotfiles-cli";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "dotfiles";
  };
}
