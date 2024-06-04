{ config, pkgs, systemSettings, ...}:
{
	programs.waybar = {
		enable = true;
		# settings = {};
		style = ./tokyonight-night-style.css;
	};
	home.file.".config/waybar/config.jsonc".source = if systemSettings.computerType == "laptop"
		then ./laptop-config.jsonc
		else ./desktop-config.jsonc;
}
