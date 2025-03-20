{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  # renovate: datasource=github-releases depName=danihek/hellwal
  pname = "hellwal";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "danihek";
    repo = "hellwal";
    rev = "v${version}";
    sha256 = "sha256-ei612uqAdEDwodsVDkmI4CGASMzCC/q0+CuNS54B53U=";
  };

  buildInputs = [ ];

  nativeBuildInputs = [ stdenv.cc ];

  postPatch = ''
    rm -f "hellwal"
  '';

  installPhase = ''
    mkdir -p $out/bin
    make DESTDIR=$out/bin install
  '';

  meta = with lib; {
    description = "Pywal-like color palette generator, but faster and in C";
    homepage = "https://github.com/danihek/hellwal";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
