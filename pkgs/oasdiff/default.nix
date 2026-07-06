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
  version = "1.22.0";

  src = fetchFromGitHub {
    owner = "oasdiff";
    repo = "oasdiff";
    rev = "v" + version;
    hash = "sha256-DF2JqUB6Ny6kPErzk9p/IJiSCZ7T2JcJmCNsF5hRkCk=";
  };
  vendorHash = "sha256-U0WwmuiU4Wf/va1G+7dHEa0k3wSKgTKJ5kV3jI0Z7yw=";

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
