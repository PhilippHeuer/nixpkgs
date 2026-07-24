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
  version = "0.0.27";

  src = fetchFromGitHub {
    owner = "pb33f";
    repo = "printing-press";
    rev = "refs/tags/v${version}";
    hash = "sha256-Jd0igQ17e7Z8e1kHokVxjsuzyVC/LKSpW5F7RzGayKc=";
  };

  vendorHash = "sha256-cseqDdw43IZiAEiFc2gn0qWVzc+GqCy7cLJDB+t1uM0=";

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
