{ config, pkgs, userSettings, ...}:
{
    home.packages = with pkgs; [
        # xdg-desktop-portal-xapp #################### CHECK was activated
        # hypridle
        # hyprlock
    ];

    wayland.windowManager.hyprland = {
        enable = true; # done from configuration.nix ################### CHECK was on but probably not needed? Yess///
            systemd.variables = ["--all"]; # try disabling: so that programs can be run outside of terminal (system needs to import environment)

            extraConfig = ''
            source = ~/.config/hypr/dev-specific/monitor-specific.conf
            source = ~/.config/hypr/dev-specific/keyboard-specific.conf
            source = ~/.config/hypr/windowRules.conf
            source = ~/.config/hypr/binds.conf
            source = ~/.config/hypr/graphics.conf
            exec-once = swww-daemon &
            exec-once = /usr/bin/env bash ~/.config/hypr/startup.sh
            exec-once = startWpRotation ${../../../data/wallpapers/selected} &
            # exec-once = hyprctl setcursor Vanilla-DMZ 24
                                                              '';
    };

    home.file.".config/hypr/binds.conf".source = ./binds.conf;
    home.file.".config/hypr/graphics.conf".source = ./graphics.conf;
    home.file.".config/hypr/startup.sh".source = ./startup.sh;
    home.file.".config/hypr/windowRules.conf".source = ./windowRules.conf;
    # home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    # home.file.".config/hypr/hyprlockWallpaper.png".source = ./hyprlockWallpaper.png;
    # home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
    home.file.".config/hypr/dev-specific/monitor-specific.conf".source = if userSettings.monitorType == "desktop" then ./dev-specific/monitor-desktop.conf else ./dev-specific/monitor-asusLaptop.conf;
    home.file.".config/hypr/dev-specific/keyboard-specific.conf".source = if userSettings.keyboard == "fullSize" then ./dev-specific/binds-fullSize-specific.conf else ./dev-specific/binds-laptop-specific.conf;

# services.hypridle.enable = true; # try it some time!
# programs.hyprlock.enable = true; # try it some time!



############################### CHECK try nuking all of this more or less
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
                xdg-desktop-portal-kde
                xdg-desktop-portal-gnome
                xdg-desktop-portal-wlr
        ];
        config = {
            common = {
                default = [
                    "gtk"
                ];
            };
        pantheon = {
            default = [
                "pantheon"
                    "gtk"
            ];
            "org.freedesktop.impl.portal.Secret" = [
                "gnome-keyring"
            ];
        };
        x-cinnamon = {
            default = [
                "xapp"
                    "gtk"
            ];
        };
    };
    };
}
