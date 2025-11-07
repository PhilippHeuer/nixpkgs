{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "driveguard";
  version = "v0.1.4";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "driveguard";
    rev = "9b88a6f2238e0ff5b18b2e47fa810bb52ed7614f";
    sha256 = "sha256-VBiGzssjoA3dU9gd27spxwxeKzTW073nS0cw4Pa+emU=";
    private = true;
    forceFetchGit = true;
  };

  vendorHash = "sha256-A7phh+lNfCEWrWvKmLHCL9+lu7Yq1ZsAI2exKeDEMN8=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.commit=none"
    "-X main.date=none"
    "-X main.status=clean"
  ];

  # disable checks
  doCheck = false;

  # metadata
  meta = with lib; {
    homepage = "https://github.com/PhilippHeuer/driveguard";
    description = "DriveGuard will monitor drive health and automatically send notifications if any issues are detected.";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "driveguard";
  };
}
