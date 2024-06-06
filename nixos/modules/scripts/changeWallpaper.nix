{pkgs}:
pkgs.writeShellScriptBin "startWpRotation" ''

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2


	find "/home/nileoe/Pictures/wallpapers/" -type f \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| read -r img
			swww img "$img"
''
