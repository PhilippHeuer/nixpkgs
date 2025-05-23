{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  # renovate: datasource=github-releases depName=danihek/hellwal
  pname = "hellwal";
  version = "1.0.4";

  src = fetchFromGitHub {
    owner = "danihek";
    repo = "hellwal";
    rev = "v${version}";
    sha256 = "sha256-M+b49KhbzvwpMvnfiNe4yy50aUjrGXEajLMmiXEOCgE=";
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
