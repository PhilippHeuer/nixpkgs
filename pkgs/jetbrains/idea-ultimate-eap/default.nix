{
  pkgs,
}:

(pkgs.jetbrains.idea-ultimate.overrideAttrs(oldAttrs: {
    version = "2025.2 Beta";
    src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/idea/ideaIU-252.13776.59.tar.gz";
        sha256 = "862e7d15b0f8cbd752f969684885a47ffb1e32a2c495089176af92d12164ecad";
    };
    build_number = "252.13776.59";

    buildInputs = (oldAttrs.buildInputs or []) ++ [
      pkgs.libGL
      pkgs.xorg.libX11
      pkgs.fontconfig
    ];
}))
