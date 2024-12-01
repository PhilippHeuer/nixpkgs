{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "driveguard";
  version = "v0.1.2";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "driveguard";
    rev = "115a7678284bb915d1ab36ab8b34b2327ee2e0a4";
    sha256 = "sha256-tmRuGYIhNMLRwnqCifUh4hXR0qwTr+58SyzAnK1m4Dk=";
    private = true;
    forceFetchGit = true;
  };

  vendorHash = "sha256-eEq7jNMtkbr7hKF3tAmj/7O8hR0ALQDL1i5q+r920Cg=";

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
