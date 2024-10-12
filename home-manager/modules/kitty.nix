# more complex config: seel
# https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
{ config, pkgs, sessionSettings, ...}:
{
    programs.kitty = {
        enable = true;
	themeFile = "tokyo_night_night";
        font = {
            name = sessionSettings.monospaceFont;
        };
        settings = {
            enable_audio_bell = "no"; # for the love of everything that is holy
        };
    };
}
