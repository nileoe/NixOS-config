# more complex config: seel
# https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
{ config, pkgs, sessionSettings, ...}:
{
    programs.kitty = {
        enable = true;
        theme = "Tokyo Night";
        # theme = "Rosé Pine";
        # theme = "Night Owl";
        font = {
            name = sessionSettings.monospaceFont;
        };
        settings = {
            enable_audio_bell = "no"; # for the love of everything that is holy
        };
    };
}
