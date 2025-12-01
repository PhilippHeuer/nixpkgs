{ lib
, python3
, python3Packages
, fetchFromGitHub
, gobject-introspection
, wrapGAppsHook3
, killall
}:

python3.pkgs.buildPythonApplication rec {
  pname = "waypaper";
  version = "0.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "philippheuer";
    repo = "waypaper";
    rev = "c86462fdcd29937b613e3354da3bf98977e6cd44";
    hash = "sha256-gh3Mip9pUHbn7xM1IDR5UA+ueCTH+Bs0X1WO6pYDu3I=";
  };

  build-system = with python3Packages; [ setuptools ];

  nativeBuildInputs = [
    gobject-introspection
    wrapGAppsHook3
  ];

  propagatedBuildInputs = [
    python3.pkgs.pygobject3
    python3.pkgs.platformdirs
    python3.pkgs.importlib-metadata
    python3.pkgs.pillow
    killall
  ];

  # has no tests
  doCheck = false;

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  meta = with lib; {
    changelog = "https://github.com/philippheuer/waypaper/releases/tag/${version}";
    description = "GUI wallpaper setter for Wayland-based window managers";
    mainProgram = "waypaper";
    longDescription = ''
      GUI wallpaper setter for Wayland-based window managers that works as a frontend for popular backends like swaybg and swww.

      If wallpaper does not change, make sure that swaybg or swww is installed.
    '';
    homepage = "https://github.com/philippheuer/waypaper";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
