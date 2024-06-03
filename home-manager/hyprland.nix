{ config, pkgs, ...}:
let
theme = "poire";
in
{
	programs.hyprland = {
	enable = true;
	};
	# services.hypridle.enable = true; # try it some time!
	# programs.hyprlock.enable = true; # try it some time!
}
