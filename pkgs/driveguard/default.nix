{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "driveguard";
  version = "v0.1.3";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "driveguard";
    rev = "657f95bec5119d115deb2b51678dcf857da299db";
    sha256 = "sha256-0Z2qt5qihvgUFMBxLRI2e0k91CgMLK6nJN4AOzu7SbA=";
    private = true;
    forceFetchGit = true;
  };

  vendorHash = "sha256-N16gZyV856Jhhzx6rPsSkeVQag9shSxBWZVkh4W4g0s=";

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
