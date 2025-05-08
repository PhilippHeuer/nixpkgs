{
  lib,
  stdenv,
  fetchzip,
  installShellFiles,
}:

let
  # renovate: datasource=github-releases depName=JetBrains/qodana-cli
  pname = "qodana";
  version = "2025.1.1";

  src = fetchTarball {
    url = "https://github.com/JetBrains/qodana-cli/releases/download/v${version}/qodana_linux_x86_64.tar.gz";
    sha256 = "sha256:19w23x0hm7slla1bs81f6cs95czi2jqfs38q3z83jybgfp1nmf93";
  };
in
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ installShellFiles ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -R qodana $out/bin/qodana
    chmod +x $out/bin/qodana

    runHook postInstall
  '';

  # disable checks
  doCheck = false;

  postInstall = ''
    installShellCompletion --cmd qodana \
      --bash <($out/bin/qodana completion bash) \
      --fish <($out/bin/qodana completion fish) \
      --zsh <($out/bin/qodana completion zsh)
  '';

  meta = {
    description = "JetBrains Qodana’s official command line tool ";
    longDescription = ''
      🔧 Run Qodana as fast as possible, with minimum effort required
    '';
    homepage = "https://www.jetbrains.com/help/qodana/getting-started.html";
    changelog = "https://github.com/JetBrains/qodana-cli/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "qodana";
  };
}
