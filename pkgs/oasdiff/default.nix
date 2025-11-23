{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
  git,
  gitUpdater,
}:

buildGoModule rec {
  pname = "oasdiff";
  version = "v1.11.7";

  src = fetchFromGitHub {
    owner = "oasdiff";
    repo = "oasdiff";
    rev = version;
    hash = "sha256-QfTJEwHsjO4ilbU18iDzCCthhb5s2JZRsGIB+SQiBaI=";
  };
  vendorHash = "sha256-TGkaEH1cExkMJOVJ5iUgnBhb3P9hQhpbC8FIGdtHk5A=";

  nativeBuildInputs = [ makeWrapper ];

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
