{pkgs}:
pkgs.writeShellScriptBin "toggleWallpaper" ''
kill $(pidof swww-daemon) || (swww-daemon && change_wallpaper&)
''
