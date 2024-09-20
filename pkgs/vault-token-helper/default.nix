{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "vault-token-helper";
  version = "v0.3.7";

  src = fetchFromGitHub {
    owner = "joemiller";
    repo = "vault-token-helper";
    rev = version;
    sha256 = "sha256-MfY57qlceBVzLyQgPo8SbT9bG7akhMaOIkmcdv6q2wM=";
  };
  vendorHash = "sha256-b/ufutR2JUgmPQBgif24ipAh7TWaqxo+sGCDv4BvdHU=";

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
      installShellCompletion --cmd vault-token-helper \
        --bash <($out/bin/vault-token-helper completion bash) \
        --fish <($out/bin/vault-token-helper completion fish) \
        --zsh  <($out/bin/vault-token-helper completion zsh)
    '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/joemiller/vault-token-helper";
    description = "Vault Token Helper for macOS, Linux and Windows with support for secure token storage and multiple Vault servers";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "vault-token-helper";
  };
}
