{
  stdenv,
  lib,
  buildGo124Module,
  fetchFromGitHub,
}:

buildGo124Module rec {
  # renovate: datasource=github-releases depName=krakend/krakend-ce
  pname = "krakend-ce";
  version = "2.11.1";

  src = fetchFromGitHub {
    owner = "krakend";
    repo = "krakend-ce";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-Aopbdf2HT14xcVS7q+eCHqYScTcgGJuyaT4tqLEMbEU=";
  };

  vendorHash = "sha256-mOjprJHUxDRwB58f2vvrolcnCDUg16R0CwmX7TeU9M4=";

  doCheck = false;

  subPackages = [ "./cmd/krakend-ce" ];

  ldflags = [
    "-X github.com/krakendio/krakend-ce/v2/pkg.Version=${version}"
    "-X github.com/luraproject/lura/v2/core.GlibcVersion=${stdenv.cc.libc.version}"
    "-X github.com/luraproject/lura/v2/core.KrakendVersion=${version}"
  ];

  postInstall = ''
    mv $out/bin/* $out/bin/krakend
  '';

  meta = with lib; {
    description = "KrakenD Community Edition: High-performance, stateless, declarative, API Gateway written in Go. ";
    homepage = "https://www.krakend.io/";
    changelog = "https://github.com/krakend/krakend-ce/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
    mainProgram = "krakend";
  };
}
