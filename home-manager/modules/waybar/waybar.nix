{ config, pkgs, systemSettings, ...}:
{
	programs.waybar = {
		enable = true;
		# settings = {};
		# style = ./tokyonight-night-style.css;
		style = ./firefox-dark.css;
	};
	home.file.".config/waybar/config.jsonc".source = if systemSettings.monitorType == "laptop"
		then ./laptop-config.jsonc
		else ./desktop-config.jsonc;
}
