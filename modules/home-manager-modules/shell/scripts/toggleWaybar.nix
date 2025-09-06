{pkgs}:
pkgs.writeShellScriptBin "toggleWaybar" ''
  kill $(pidof waybar) || waybar &
''
