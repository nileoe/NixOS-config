{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.pointerCursor = {
    gtk.enable = true;
    # package = pkgs.vanilla-dmz;
    package = pkgs.catppuccin-cursors.mochaLavender;
    # name = "Vanilla-DMZ";
    # name = "Catppuccin Mocha Lavender";
    # name = "Yaru";
    name = "mochaLavender";
    size = 24;

    # why no work
    #        package = pkgs.graphite-cursors;
    # name = "graphite-cursors";
  };
  gtk = {
    enable = true;
    theme = {
      # package = pkgs.nordic;
      # name = "Nordic";
      # WORKING OPTIONS
      # package = pkgs.numix-gtk-theme;
      # name = "Numix";
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
      # package = pkgs.sweet;
      # name = "Sweet";
    };
    iconTheme = {
      # TESTING
      # WORKING OPTIONS
      # package = pkgs.beauty-line-icon-theme;
      # name = "BeautyLine";
      # package = pkgs.candy-icons;
      # name = "candy-icons";
      package = pkgs.kora-icon-theme;
      name = "kora";
      # package = pkgs.tela-icon-theme;
      # name = "Tela-blue-dark";
    };
    #  cursorTheme = {
    # inherit (cfg.cursors) package;
    # inherit (cfg.cursors) name;
    #  };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = "1";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = "1";
    };
  };
  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };
}
#    cursorTheme = {
#    };
# iconTheme = {
#     name = "Adwaita";
#     package = pkgs.gnome.adwaita-icon-theme;
# };
# catppuccin = {
#   enable = true;
#   flavor = "mocha";
#   # accent: blue, flamingo, green, lavender, maroon, mauve, peach, pink, red, rosewater, saphire, sky, teal, yellow
#   accent = "lavender";
#   size = "standard";
#   tweaks = [ "normal" ];
# };

