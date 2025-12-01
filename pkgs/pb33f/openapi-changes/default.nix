{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
  installShellFiles,
  git,
  gitUpdater,
}:

buildGoModule rec {
  pname = "openapi-changes";
  version = "0.0.87";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "pb33f-openapi-changes";
    #owner = "pb33f";
    #repo = "openapi-changes";
    rev = "v" + version;
    hash = "sha256-L/vm+IrKa/MciarvgjIgDBfuDK/Fr31Xw0HIQx5oSo4=";
  };
  vendorHash = "sha256-Ep1YhxReG7UbRM9s0KVO9LPRur2HwAwjZWNsvRQWf6U=";

  patchPhase = ''
    rm git/read_local_test.go
  '';

  nativeBuildInputs = [ makeWrapper installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd openapi-changes \
      --bash <($out/bin/openapi-changes completion bash) \
      --fish <($out/bin/openapi-changes completion fish) \
      --zsh <($out/bin/openapi-changes completion zsh)

      wrapProgram $out/bin/openapi-changes --prefix PATH : ${lib.makeBinPath [ git ]}
  '';

  passthru.updateScript = gitUpdater {
    rev-prefix = "v";
  };

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
