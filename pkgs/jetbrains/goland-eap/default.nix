{
  pkgs,
}:

(pkgs.jetbrains.goland.overrideAttrs {
    version = "2025.1 Beta";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/go/goland-251.23774.216.tar.gz";
        sha256 = "9c74be72b091a866d35b3561f697c4161750dee8350e7b2f3563b6012c9333d0";
    };
    build_number = "251.23774.216";
})
