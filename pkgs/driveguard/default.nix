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
    rev = "d279c3bfbce3355b8be5f32b6a30330bb5013860";
    sha256 = "sha256-MIlHkGHiGZQPKMLQG0yljm/VDEAL2N4ztI5+9pr77tU=";
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
