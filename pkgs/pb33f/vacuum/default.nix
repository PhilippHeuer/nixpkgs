{ lib
, buildGoModule
, fetchFromGitHub
, installShellFiles
}:

buildGoModule rec {
  pname = "vacuum";
  version = "0.9.16";

  src = fetchFromGitHub {
    owner = "daveshanley";
    repo = "vacuum";
    rev = "99df10d7e2f8dd811c2f00f765ec6ef5568164fd";
    sha256 = "sha256-gMEFGbHAXUK4kh7lbiC7ecBBH8owTDzLYionMTT0UjU=";
  };

  vendorHash = "sha256-NUMo/brMkCKGUaTZv2ojSsGHcf/7ppYOcXjYoXGQRCQ=";

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
  };
}