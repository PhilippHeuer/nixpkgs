{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "gocheat";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "Achno";
    repo = "gocheat";
    rev = version;
    sha256 = "sha256-qDHUFNSnHkc59Yemzm3ntTAgOsYljqWHqrgyQzG59os=";
  };
  vendorHash = "sha256-udCnevoOsZgBQILsPYP6TPCNqHD2MEAL6WXWaxjUel0=";

  ldflags = [
    "-s"
    "-w"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  # completions
  postInstall = ''
      # install shell completion
      installShellCompletion --cmd gocheat \
        --bash <($out/bin/gocheat completion bash) \
        --fish <($out/bin/gocheat completion fish) \
        --zsh  <($out/bin/gocheat completion zsh)
    '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/Achno/gocheat";
    description = "A beautiful customizable Cheatsheet for keybindings,hotkeys and more in the terminal";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "gocheat";
  };
}
