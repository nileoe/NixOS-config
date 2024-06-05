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
		 initExtra = ''
			bindkey '^o' autosuggest-accept
			function mkcd() { # creates a directory and cd into it in a single command.
			    mkdir "$1"
			    cd "$1"
			}

			function rpc() { # copies provided file's absolute path in clipboard (needs wl-copy)
			    realpath "$1" | wl-copy
			}

            if [ -n "''${commands[fzf-share]}" ]; then
                source "$(fzf-share)/key-bindings.zsh"
                source "$(fzf-share)/completion.zsh"
            fi
        '';
# 	source ~/nix-config/home-manager/p10k-config/p10k.zsh
    };
}
