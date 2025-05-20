{
  pkgs,
}:

(pkgs.jetbrains.goland.overrideAttrs {
    version = "2025.2 eap";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/go/goland-252.13776.68.tar.gz";
        sha256 = "8c8d2653020b36ebb115799c92915b4a1f69c6529f0ccf5078e0f9074a0215d6";
    };
    build_number = "252.13776.68";
})
