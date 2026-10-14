{
  lib,
  buildGo126Module,
  fetchFromGitHub,
  installShellFiles,
  nix-update-script,
}:

buildGo126Module rec {
  # renovate: datasource=github-releases depName=pb33f/printing-press
  pname = "printing-press";
  version = "0.0.28";

  src = fetchFromGitHub {
    owner = "pb33f";
    repo = "printing-press";
    rev = "refs/tags/v${version}";
    hash = "sha256-1jTcLKaN2eZdAmojz7oWQhuRrkef9U0MOxgNd9VsXJc=";
  };

  vendorHash = "sha256-yjFCtxnMpG5bJluEqDZurXldUBWKyv/eJBv+2MZSjxA=";

  doCheck = false;

  subPackages = [ "." ];

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    mv $out/bin/printing-press $out/bin/ppress
    installShellCompletion --cmd ppress \
      --bash <($out/bin/ppress completion bash) \
      --fish <($out/bin/ppress completion fish) \
      --zsh <($out/bin/ppress completion zsh)
  '';

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Industrial strength OpenAPI Documentation in seconds.";
    longDescription = '''';
    homepage = "https://quobix.com/printing-press";
    changelog = "https://github.com/pb33f/printing-press/releases/tag/v${version}";
    #license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "ppress";
  };
}
