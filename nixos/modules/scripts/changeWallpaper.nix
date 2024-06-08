{pkgs}:
pkgs.writeShellScriptBin "changeWallpaper" ''

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2


WPDIR=${../../../data/wallpapers/selected}
echo "found wpdir: $WPDIR"

read -r wp < <(find $WPDIR -type f \
    | while read -r wp; do
    echo "$((RANDOM % 1000)):$wp"
done \
    | sort -n | cut -d':' -f2-)
swww img "$wp"
''
