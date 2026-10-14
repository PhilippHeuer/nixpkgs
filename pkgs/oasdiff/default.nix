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
  version = "1.33.0";

  src = fetchFromGitHub {
    owner = "oasdiff";
    repo = "oasdiff";
    rev = "v" + version;
    hash = "sha256-tCRk5lgZFTpGlI6w0gniaorRnJMYi/g7wcYBcMIfks0=";
  };
  vendorHash = "sha256-OEZgmxEQ8OKVkfk0009+2HdoKXyImI/1VnLi6P0EkEQ=";

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
