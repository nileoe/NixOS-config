# more complex config: seel
# https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
{ config, pkgs, ...}:
{
programs.kitty = {
	enable = true;
	theme = "Tokyo Night";
	font = {
		name = "JetBrainsMonoNerdFont";
	};
    settings = {
        enable_audio_bell = "no";
    };
};
}
