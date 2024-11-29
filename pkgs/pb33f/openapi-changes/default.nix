{ lib
, buildGoModule
, fetchFromGitHub
, installShellFiles
}:

buildGoModule rec {
  pname = "openapi-changes";
  version = "v0.0.62";

  src = fetchFromGitHub {
    owner = "pb33f";
    repo = "openapi-changes";
    rev = "24cdab383715d42431a50db602727189b70027df";
    sha256 = "sha256-5RPJVZR2TwF0TYbALEdZ0CbmEsPE3i2Udu7wsyCU1Q0=";
  };

  vendorHash = "sha256-zcglAMAqLfDmv8Ymrs7elIA7I6/HL4qp630QfUU1iw0=";

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
    maintainers = with lib.maintainers; [];
  };
}