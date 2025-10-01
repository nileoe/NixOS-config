{
  config,
  pkgs,
  userSettings,
  ...
}: {
  home.packages = with pkgs; [
    hyprcursor
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # systemd.variables = ["--all"]; # try disabling: so that programs can be run outside of terminal (system needs to import environment)

    extraConfig = ''
      source = ~/.config/hypr/dev-specific/monitor-specific.conf
      source = ~/.config/hypr/dev-specific/keyboard-specific.conf
      source = ~/.config/hypr/windowRules.conf
      source = ~/.config/hypr/binds.conf
      source = ~/.config/hypr/input.conf
      source = ~/.config/hypr/graphics.conf
      source = ~/.config/hypr/animations.conf
      exec-once = /usr/bin/env bash ~/.config/hypr/startup.sh
      exec-once = swww-daemon &
      exec-once = startWpRotation ${/etc/nixos/data/wallpapers/selected} &
    '';
  };

  home.file = {
    ".config/hypr/binds.conf".source = ./binds.conf;
    ".config/hypr/input.conf".source = ./input.conf;
    ".config/hypr/graphics.conf".source = ./graphics.conf;
    ".config/hypr/startup.sh".source = ./startup.sh;
    ".config/hypr/windowRules.conf".source = ./windowRules.conf;
    ".config/hypr/animations.conf".source = ./animations.conf;
    ".config/hypr/dev-specific/monitor-specific.conf".source =
      if userSettings.monitorType == "desktop"
      then ./dev-specific/monitor-desktop.conf
      else ./dev-specific/monitor-asusLaptop.conf;
    ".config/hypr/dev-specific/keyboard-specific.conf".source =
      if userSettings.keyboard == "fullSize"
      then ./dev-specific/binds-fullSize-specific.conf
      else ./dev-specific/binds-laptop-specific.conf;
  };
}
