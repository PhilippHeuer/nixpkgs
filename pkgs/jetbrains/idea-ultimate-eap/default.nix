{
  pkgs,
}:

(pkgs.jetbrains.idea-ultimate.overrideAttrs(oldAttrs: {
    version = "2025.2 EAP 7";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/idea/ideaIU-252.23591.19.tar.gz";
        sha256 = "05e469f3c98fb91f780176275e582d5e1d54c48a574e244b07fa3031e1d0997d";
    };
    build_number = "252.23591.19";

    buildInputs = (oldAttrs.buildInputs or []) ++ [
      pkgs.libGL
      pkgs.xorg.libX11
      pkgs.fontconfig
    ];
}))
