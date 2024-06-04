{ config, pkgs, sessionSettings, ...}:
{
	wayland.windowManager.hyprland = {
	enable = true; # done from configuration.nix
	systemd.variables = ["--all"]; # try disabling: so that programs can be run outside of terminal (system needs to import environment)
	
	extraConfig = ''
		source = ~/.config/hypr/dev-specific/monitor.conf
		source = ~/.config/hypr/dev-specific/dev-specific_binds.conf
		source = ~/.config/hypr/windowRules.conf
		source = ~/.config/hypr/binds.conf
		source = ~/.config/hypr/graphics.conf
		source = ~/.config/hypr/startup.conf
		windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
		debug:disable_logs = false
	'';
	};

	# always sourcing the desktop config for now
	# home.file.".config/hypr/hyprland.conf".source = ./desktop-hyprland.conf;
	home.file.".config/hypr/binds.conf".source = ./binds.conf;
	home.file.".config/hypr/graphics.conf".source = ./graphics.conf;
	home.file.".config/hypr/startup.conf".source = ./startup.conf;
	home.file.".config/hypr/windowRules.conf".source = ./windowRules.conf;
	home.file.".config/hypr/dev-specific/monitor.conf".source = ./dev-specific/monitor-1440p144hz.conf;
	home.file.".config/hypr/dev-specific/dev-specific_binds.conf".source = ./dev-specific/g915-specific_binds.conf;

	# services.hypridle.enable = true; # try it some time!
	# programs.hyprlock.enable = true; # try it some time!
}
