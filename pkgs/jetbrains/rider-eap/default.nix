{
  pkgs,
}:

(pkgs.jetbrains.rider.overrideAttrs {
    version = "2025.1 EAP 9";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/rider/JetBrains.Rider-2025.1-EAP9-251.23774.212.Checked.tar.gz";
        sha256 = "60db3a6cf5e4bd2e6cbaabcf3d53ebad81c6e4e16ced89414cabf5468fef6b6e";
    };
    build_number = "251.23774.212";
})
