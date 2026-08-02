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
  version = "1.27.0";

  src = fetchFromGitHub {
    owner = "oasdiff";
    repo = "oasdiff";
    rev = "v" + version;
    hash = "sha256-n0svl39gtqa8MrNAeRDZtmH/JcqcsXjFvsn1HjofMZU=";
  };
  vendorHash = "sha256-hV83ROWElYYaK/zkwSp436Lg/f2U/CcknmPuS9vB+gc=";

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
