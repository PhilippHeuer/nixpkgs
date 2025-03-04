{
  pkgs,
}:

(pkgs.jetbrains.idea-ultimate.overrideAttrs {
    version = "2025.1 EAP";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/idea/ideaIU-251.23536.34.tar.gz";
        sha256 = "14f844e54c97a1b401ba15de078a54bc1d4e5ebf408dc67e352aee6ce235933f";
    };
    build_number = "251.23536.34";
})
