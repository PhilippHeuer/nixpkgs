{ lib
, python3
, fetchFromGitHub
, gobject-introspection
, wrapGAppsHook3
, killall
}:

python3.pkgs.buildPythonApplication rec {
  pname = "waypaper";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "philippheuer";
    repo = "waypaper";
    rev = "9450456283911babb87c03d34493803f21a1559d";
    hash = "sha256-Jpwu6AwyHenRfQ9ysp3Zu7npVu6yCdnngFY7H732y10=";
  };

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
