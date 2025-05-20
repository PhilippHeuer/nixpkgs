{
  pkgs,
}:

(pkgs.jetbrains.rider.overrideAttrs {
    version = "2025.2 EAP1";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/rider/JetBrains.Rider-2025.2-EAP1-252.13776.73.Checked.tar.gz";
        sha256 = "16a097fde021ff91be0953aa5bb65bdbe1f047fcb29f44b4215cf9f9bfb42a99";
    };
    build_number = "252.13776.73";
})
