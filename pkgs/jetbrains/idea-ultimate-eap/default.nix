{
  pkgs,
}:

(pkgs.jetbrains.idea-ultimate.overrideAttrs {
    version = "2025.1 Beta";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/idea/ideaIU-251.23774.200.tar.gz";
        sha256 = "7ce57055e3a5ee92582eb90c2dea469b48a6e7165e74fe085ef1923c16ba7faa";
    };
    build_number = "251.23774.200";
})
