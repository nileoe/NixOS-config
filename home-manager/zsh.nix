{ config, pkgs, ...}:
{
	programs.zsh = {
# already enabled from higher up
enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		history.size = 10000;

		plugins = [
		{
			name = "powerlevel10k";
			src = pkgs.zsh-powerlevel10k;
			file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
		}
		{
			name = "powerlevel10k-config";
			src = ./p10k-config;
			file = "p10k.zsh";
		}
		];

	};
}
