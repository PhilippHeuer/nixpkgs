{
  pkgs,
}:

(pkgs.jetbrains.goland.overrideAttrs {
    version = "2025.1 EAP";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/go/goland-251.23536.46.tar.gz";
        sha256 = "7fe3ece0c9fc07c59f6b7e68878b615206a23f0ba43fbf414d4b2e7ad90ed4bc";
    };
    build_number = "251.23536.46";
})
