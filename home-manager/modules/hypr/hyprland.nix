{ config, pkgs, sessionSettings, systemSettings, ...}:
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
            exec-once = swww-daemon &
            exec-once = startWpRotation ${../../../data/wallpapers/selected} &
            exec-once = /usr/bin/env bash ~/.config/hypr/startup.sh
                                                              '';
    };

    home.file.".config/hypr/binds.conf".source = ./binds.conf;
    home.file.".config/hypr/graphics.conf".source = ./graphics.conf;
    home.file.".config/hypr/startup.sh".source = ./startup.sh;
    home.file.".config/hypr/windowRules.conf".source = ./windowRules.conf;
    home.file.".config/hypr/dev-specific/monitor.conf".source = if systemSettings.monitorType == "desktop" then ./dev-specific/monitor-1440p144hz.conf else ./dev-specific/monitor-asusLaptop.conf;
    home.file.".config/hypr/dev-specific/dev-specific_binds.conf".source = if systemSettings.keyboard == "fullSize" then ./dev-specific/binds-fullSize-specific.conf else ./dev-specific/binds-laptop-specific.conf;

# services.hypridle.enable = true; # try it some time!
# programs.hyprlock.enable = true; # try it some time!


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
