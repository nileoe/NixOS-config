{
  config,
  pkgs,
  userSettings,
  ...
}: {
  programs.waybar = {
    enable = true;
    # settings = {};
    # style = ./tokyonight-night-style.css;
    style =
      if userSettings.style == "minimal"
      then ./style-minimal.css
      else ./style-riced.css;
  };
  home.file.".config/waybar/config.jsonc".source =
    if userSettings.monitorType == "laptop"
    then
      if userSettings.style == "minimal"
      then ./laptop-config-minimal.jsonc
      else ./laptop-config-riced.jsonc
    else if userSettings.style == "minimal"
    then ./desktop-config-minimal.jsonc
    else
      ./desktop-config-riced.jsonc
      ./desktop-config.jsonc;
}
