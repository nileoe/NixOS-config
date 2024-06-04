{ config, pkgs, ...}:
{
	programs.waybar = {
		enable = true;
#		settings = {
#		mainBar = 
#		};
		style = ./tokyonight-night-style.css
	};
}
