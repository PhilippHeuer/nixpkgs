{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  versionCheckHook,
  cacert,
  gitMinimal,
  pkg-config,
  z3,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "openshell";
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

  nativeCheckInputs = [
    cacert
    gitMinimal
  ];

  postPatch = ''
    # fill in package version to Cargo
    substituteInPlace Cargo.toml \
      --replace-fail 'version = "0.0.0"' 'version = "${finalAttrs.version}"'
    # only build openshell-cli crate
    substituteInPlace Cargo.toml \
      --replace-fail 'members = ["crates/*"]' 'members = ["crates/openshell-cli"]'
  '';

  env = {
    # docker image tag baked in at compile time, must match binary version
    OPENSHELL_IMAGE_TAG = finalAttrs.version;
  };

  doCheck = false;

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;

  meta = {
    changelog = "https://github.com/NVIDIA/OpenShell/releases/tag/v${finalAttrs.version}";
    description = "The safe, private runtime for autonomous AI agents.";
    homepage = "https://docs.nvidia.com/openshell/index.html";
    license = lib.licenses.asl20;
    longDescription = ''
      NVIDIA OpenShell is an open source runtime to build and deploy autonomous,
      self-evolving agents more safely. OpenShell sits between your agent and
      your infrastructure to govern how the agent executes, what the agent can
      see and do, and where inference goes. It enables claws to run in isolated
      sandboxes, with fine-grained control over privacy and security.
    '';
    mainProgram = "openshell";
    platforms = lib.platforms.all;
  };
})
