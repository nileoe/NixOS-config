{ config, pkgs, sessionSettings, ...}:
{
	programs.hyprland = {
	enable = false;
	};
	# services.hypridle.enable = true; # try it some time!
	# programs.hyprlock.enable = true; # try it some time!

	# always sourcing the desktop config for now

	home.file.".confi/hypr/hyprland.conf".source = ./desktopHyprland.conf;
	home.file.".confi/hypr/binds.conf".source = ./binds.conf;
	home.file.".confi/hypr/graphics.conf".source = ./graphics.conf;
	home.file.".confi/hypr/startup.conf".source = ./startup.conf;
	home.file.".confi/hypr/windowRules.conf".source = ./windowRules.conf;
	home.file.".confi/hypr/dev-specific/monitor.conf".source = ./dev-specific/monitor-1440p144hz.conf;
	home.file.".confi/hypr/dev-specific/dev-specific_binds.conf".source = ./dev-specific/g915-specific_binds.conf;
}
