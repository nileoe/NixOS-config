{ config, pkgs, ...}:
{
	programs.waybar = {
		enable = true;
		# settings = {
		# mainBar = {}
		# };
		style = ./tokyonight-night-style.css;
	};
	home.file.".config/waybar/config.jsonc".source = ./desktop-config.jsonc;
}
