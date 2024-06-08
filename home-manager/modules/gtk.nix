{config, pkgs, inputs, ...}:
{
  gtk = {
    iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
    };
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "mocha";
      # accent: blue, flamingo, green, lavender, maroon, mauve, peach, pink, red, rosewater, saphire, sky, teal, yellow
      accent = "lavender";
      size = "standard";
      tweaks = [ "normal" ];
    };
  };
}
