{ lib
, buildGoModule
, fetchFromGitHub
, installShellFiles
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=daveshanley/vacuum
  pname = "vacuum";
  version = "0.15.0";

  src = fetchFromGitHub {
    owner = "daveshanley";
    repo = "vacuum";
    rev = "dc29a0bf55d5bf995f9db742e3e4e067fdc08fe7";
    sha256 = "sha256-EVAfaZ/cbhBKSoAlrNP2QOM/2zKFxhe2uBoVfB4DL4c=";
  };

  vendorHash = "sha256-M9+AKgZwqnOtejIHdBF8MAWg2sJLX2cJtNdMZylp1UE=";

  doCheck = false;

  subPackages = [ "." ];

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.commit=none"
    "-X main.date=none"
  ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd vacuum \
      --bash <($out/bin/vacuum completion bash) \
      --fish <($out/bin/vacuum completion fish) \
      --zsh <($out/bin/vacuum completion zsh)
  '';

  meta = {
    description = "The world's fastest OpenAPI & Swagger linter";
    longDescription = ''
      vacuum is the worlds fastest OpenAPI 3, OpenAPI 2 / Swagger linter and quality analysis tool.
      Built in go, it tears through API specs faster than you can think.
      vacuum is compatible with Spectral rulesets and generates compatible reports.
    '';
    homepage = "https://quobix.com/vacuum/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    mainProgram = "vacuum";
  };
}