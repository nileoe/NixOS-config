{ config, pkgs, sessionSettings, ...}:
{
	wayland.windowManager.hyprland = {
	enable = false;
	};
	# services.hypridle.enable = true; # try it some time!
	# programs.hyprlock.enable = true; # try it some time!

	# always sourcing the desktop config for now

	home.file.".config/hypr/hyprland.conf".source = ./desktop-hyprland.conf;
	home.file.".config/hypr/binds.conf".source = ./binds.conf;
	home.file.".config/hypr/graphics.conf".source = ./graphics.conf;
	home.file.".config/hypr/startup.conf".source = ./startup.conf;
	home.file.".config/hypr/windowRules.conf".source = ./windowRules.conf;
	home.file.".config/hypr/dev-specific/monitor.conf".source = ./dev-specific/monitor-1440p144hz.conf;
	home.file.".config/hypr/dev-specific/dev-specific_binds.conf".source = ./dev-specific/g915-specific_binds.conf;
}
