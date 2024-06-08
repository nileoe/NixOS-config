# more complex config: seel
# https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
{ config, pkgs, ...}:
{
    home.packages = with pkgs; [
        libnotify
    ];
    services.mako = {
        enable = true;
        defaultTimeout = 10000; # in miliseconds
            ignoreTimeout = true;
        backgroundColor = "#c3e88d";
        textColor = "#1f2335"; # tokyonight
        borderRadius = 10;
    };
}
