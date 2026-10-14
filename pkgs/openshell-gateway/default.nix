
{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  z3,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "openshell-gateway";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "NVIDIA";
    repo = "OpenShell";
    tag = "v${finalAttrs.version}";
    hash = "sha256-KWM6BPhbgU8+fbxZ1yNOf0hAkjBwygcOt+wT3fzF9w8=";
  };
  cargoHash = "sha256-w4pOENcYcZH3qD43+rYFgzRUHdU4zcM/dLWsgaoUHz0=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [ z3 ];

  postPatch = ''
    substituteInPlace Cargo.toml \
      --replace-fail 'version = "0.0.0"' 'version = "${finalAttrs.version}"'
  '';

  cargoBuildFlags = [
    "-p"
    "openshell-gateway"
    "--no-default-features"
    "--features"
    "compute-driver-podman"
  ];

  doCheck = false;

  # Install only the gateway executable, not the CLI.
  installPhase = ''
    runHook preInstall

    install -Dm755 \
        target/${stdenv.hostPlatform.rust.rustcTarget}/release/openshell-gateway \
        "$out/bin/openshell-gateway"

    runHook postInstall
  '';

  meta = {
    description = "NVIDIA OpenShell gateway with the Podman compute driver";
    homepage = "https://github.com/NVIDIA/OpenShell";
    changelog = "https://github.com/NVIDIA/OpenShell/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.asl20;
    mainProgram = "openshell-gateway";
    platforms = lib.platforms.linux;
  };
})
