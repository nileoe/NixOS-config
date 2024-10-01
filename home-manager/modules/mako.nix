# more complex config: seel
# https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
{ pkgs, ...}:
{
    home.packages = with pkgs; [
        libnotify
    ];
    services.mako = {
        enable = true;
        defaultTimeout = 10000; # in miliseconds
        ignoreTimeout = true;
        # tokyonight/catpuccin-ish
        # backgroundColor = "#b4befe"; # catpuccin mocha lavender = highlight color
        # textColor = "#1f2335"; # tokyonight
	# firefox dark theme-ish
        backgroundColor = "#2B2A33";
        textColor = "#FBFBFE";
        borderRadius = 2;
	borderSize = 1;
	borderColor = "#FBFBFE";
    };
}
