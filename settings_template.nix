# to be used as device-specific global variables
# to use: rename this file as settings.nix (will be ignored by git) and use / add as you wish
{
	sessionSettings = {
		theme = {
			isDark = true;
			name = "";
		};
		timeZone = "";
	};
	userSettings = {
		username = "";
		fullName = "";
		email = ""; # used by git and such
	};
	systemSettings = {
		hostname = "";
        # so the same config can be use for laptop and desktop. Change the following
        # fields to dictate which settings (e.g. in hyprland, waybar etc.) should be used (minor differences).
		keyboard = ""; # fullSize | laptop
		monitorType = ""; # desktop | laptop
		};
}
