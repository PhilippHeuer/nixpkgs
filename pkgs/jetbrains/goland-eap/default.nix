{
  pkgs,
}:

(pkgs.jetbrains.goland.overrideAttrs {
    version = "2025.1 Beta";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/go/goland-251.23774.41.tar.gz";
        sha256 = "9c69e2b8d40fb27baf397e4d50e07e7525e9e8f3af6d6afc29f49a102da2f994";
    };
    build_number = "251.23774.41";
})
