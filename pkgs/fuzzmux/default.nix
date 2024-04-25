{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGo122Module
}:

buildGo122Module rec {
  pname = "fuzzmux";
  version = "v0.5.1";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "fuzzmux";
    rev = "95c30a7b196facdd046d645093f31c1355c7e7dc";
    sha256 = "sha256-pLT6dfaGL6nHr1CLDU0hE2Fh3npAEbJogWLPjQMVjHI=";
  };
  vendorHash = "sha256-UxFacs0DatErKEdGA4PgVu8nacyn9ddjqJajoTAbZFI=";

  ldflags = [
    "-X main.version=${version}"
    "-X main.commit=none"
    "-X main.date=none"
    "-X main.status=clean"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  # completions
  postInstall = ''
      # rename binary
      mv $out/bin/* $out/bin/tmx

      # install shell completion
      installShellCompletion --cmd tmx \
        --bash <($out/bin/tmx completion bash) \
        --fish <($out/bin/tmx completion fish) \
        --zsh  <($out/bin/tmx completion zsh)
    '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/PhilippHeuer/fuzzmux";
    description = "fuzzmux";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "tmx";
  };
}
