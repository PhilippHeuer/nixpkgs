{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:

buildGoModule rec {
  # renovate: datasource=github-releases depName=daveshanley/vacuum
  pname = "vacuum";
  version = "0.17.5";

  src = fetchFromGitHub {
    owner = "daveshanley";
    repo = "vacuum";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-QBbpDV/hlzFgrmCsywH5CC43V2Rt0fwPkf6ZCgjqqUc=";
  };

  vendorHash = "sha256-AjmET86E/xu6DTK07kMySWp5Z8W1RE/QPSe2B/IfDl0=";

  doCheck = false;

  subPackages = [ "." ];

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
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
    homepage = "https://quobix.com/vacuum";
    changelog = "https://github.com/daveshanley/vacuum/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "vacuum";
  };
}
