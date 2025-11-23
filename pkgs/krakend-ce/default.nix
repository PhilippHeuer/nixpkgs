{
  stdenv,
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=krakend/krakend-ce
  pname = "krakend-ce";
  version = "2.12.0";

  src = fetchFromGitHub {
    owner = "krakend";
    repo = "krakend-ce";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-apGugFwU1DCDggLL0cpjAjexG2GronITa7X+ralEmd8=";
  };

  vendorHash = "sha256-49uXn/FSo180l6bwPZMPaRVBRbNC4zk+TH0z64PFiz4=";

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

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = with lib; {
    description = "KrakenD Community Edition: High-performance, stateless, declarative, API Gateway written in Go. ";
    homepage = "https://www.krakend.io/";
    changelog = "https://github.com/krakend/krakend-ce/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
    mainProgram = "krakend";
  };
}
