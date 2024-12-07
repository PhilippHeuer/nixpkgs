{
  lib,
  installShellFiles,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=gorcon/rcon-cli
  pname = "rcon-cli";
  version = "v0.10.3";

  src = fetchFromGitHub {
    owner = "gorcon";
    repo = "rcon-cli";
    rev = version;
    sha256 = "sha256-S2iby8RjIQF9pr1iNLTqAaXGROYTHOI+WjaLGCJdGwA=";
  };
  vendorHash = "sha256-K3GITcOu1FlnwEdrRhgdDV2TUZWy8ig+zy5o0/S97vA=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  # completions
  postInstall = ''
    mv $out/bin/* $out/bin/rcon
  '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/gorcon/rcon-cli";
    description = "RCON client for executing queries on game server.";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "rcon";
  };
}
