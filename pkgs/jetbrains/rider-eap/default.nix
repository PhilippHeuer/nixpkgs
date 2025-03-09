{
  pkgs,
}:

(pkgs.jetbrains.rider.overrideAttrs {
    version = "2025.1 EAP 7";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/rider/JetBrains.Rider-2025.1-EAP7-251.23774.20.Checked.tar.gz";
        sha256 = "37c1c9c9237a513e62dacb474efd9beba9cd5d2024621a26f0fbd52eb736f2c9";
    };
    build_number = "251.23774.20";
})
