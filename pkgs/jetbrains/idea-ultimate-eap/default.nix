{
  pkgs,
}:

(pkgs.jetbrains.idea-ultimate.overrideAttrs {
    version = "2025.1 Beta";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/idea/ideaIU-251.23774.16.tar.gz";
        sha256 = "8ad3410cb3865976bead7e4a1f82e25b96cf32d71b1a570965e3d1d293933196";
    };
    build_number = "251.23774.16";
})
