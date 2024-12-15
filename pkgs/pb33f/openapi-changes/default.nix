{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:

buildGoModule rec {
  pname = "openapi-changes";
  version = "v0.0.69";

  src = fetchFromGitHub {
    owner = "pb33f";
    repo = "openapi-changes";
    rev = version;
    sha256 = "sha256-cCLIuS3dkC11mO1zwbGuPiMvwCVuU213OkGURgOiJqU=";
  };

  vendorHash = "sha256-IiI+mSbJNEpM6rryGtAnGSOcY2RXnvqXTZmZ82L1HPc=";

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
    installShellCompletion --cmd openapi-changes \
      --bash <($out/bin/openapi-changes completion bash) \
      --fish <($out/bin/openapi-changes completion fish) \
      --zsh <($out/bin/openapi-changes completion zsh)
  '';

  meta = {
    description = "The world's sexiest OpenAPI diff tool.";
    longDescription = ''
      The world's sexiest OpenAPI breaking changes detector.
      Discover what changed between two OpenAPI specs, or a single spec over time.
      Supports OpenAPI 3.1, 3.0 and Swagger
    '';
    homepage = "https://pb33f.io/openapi-changes/";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ ];
  };
}
