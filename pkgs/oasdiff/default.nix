{
  lib,
  buildGo126Module,
  fetchFromGitHub,
  makeWrapper,
  git,
  gitUpdater,
}:

buildGo126Module rec {
  pname = "oasdiff";
  version = "1.18.1";

  src = fetchFromGitHub {
    owner = "oasdiff";
    repo = "oasdiff";
    rev = "v" + version;
    hash = "sha256-e0NmNIN5VyMfXo4eBZbmQpBmQbtNADfUkS/ltRVWKAs=";
  };
  vendorHash = "sha256-npA5rqozEHV6R4rl1k0VcayixP5KHpFklUMjk2G3/is=";

  nativeBuildInputs = [ makeWrapper ];

  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/oasdiff --prefix PATH : ${lib.makeBinPath [ git ]}
  '';

  passthru.updateScript = gitUpdater {
    rev-prefix = "v";
  };

  meta = {
    description = "OpenAPI Diff and Breaking Changes.";
    homepage = "https://www.oasdiff.com/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
