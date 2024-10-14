{ config, pkgs, userSettings, ...}:
{
	programs.waybar = {
		enable = true;
		# settings = {};
		# style = ./tokyonight-night-style.css;
		style = ./firefox-dark.css;
	};
	home.file.".config/waybar/config.jsonc".source = if userSettings.monitorType == "laptop"
		then ./laptop-config.jsonc
		else ./desktop-config.jsonc;
}
