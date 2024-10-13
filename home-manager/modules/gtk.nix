{config, pkgs, inputs, ...}:
{
  home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.vanilla-dmz;
	name = "Vanilla-DMZ";
	size = 24;

# why no work
 #        package = pkgs.graphite-cursors;
	# name = "graphite-cursors";
  };
  gtk = {
    enable = true;
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
  };
}
