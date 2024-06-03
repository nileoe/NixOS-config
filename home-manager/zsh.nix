# more complex config: seel
# https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
{ config, pkgs, ...}:
{
programs.zsh = {
	# already enabled from higher
	enableCompletion = true;
	autosuggestion.enable = true;
	syntaxHighlighting.enable = true;
	histSize = 10000;

    initExtra = ''
      [[ ! -f ${./p10k.zsh;} ]] || source ${./p10k.zsh}
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
};
}
