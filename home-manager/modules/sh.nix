{ config, pkgs, systemSettings, userSettings, ...}:
let 
shellAliases = {
##### Basic commands / simple navigation
    cat = "bat -p --theme 'Nord'";
    catt = "bat --theme 'Nord'";
    cl = "clear";
    ll = "ls -l";
    o = "exit";
    ":q" = "exit";
    tl = "tree -L";
    gf = "fg";
    g = "grep --colour=auto";
    gi = "grep -i --colour=auto";
    cp = "cp -i";
    mv = "mv -i";
    rm = "rm -i";
    wlc = "wl-copy";
    wlp = "wl-paste";
    cw = "change_wallpaper";

##### Navigation and fzbvvbvbbvvv
    cd = "z"; # zzzzzzzoxide
    ".1" = "cd ..";
    ".2" = "cd ../../";
    ".3" = "cd ../../..";
    fzv = "nvim $(fzf --reverse)";
    fi="fzv";
    fzb = "fzf --reverse --preview 'bat --style=numbers --color=always {}'";
    fzvb = "nvim $(fzb)";
    fzbv = "fzvb";

##### Tmux
    tm = "tmux";
    tma = "tmux attach || (echo 'No current session: creating new') && sleep 0.5 && tm";

##### NixOS
    hswitch= "cd ~/nix-config && home-manager switch --flake .#${userSettings.username}@${systemSettings.hostname}";
    nswitch = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#${systemSettings.hostname}";

##### Miscellaneous
# replace / remove as needed
    airpods = "dispods; bluetoothctl connect 3C:4D:BE:89:38:4D";
    airpodso = "(airpods &) && o";
    dispods = "bluetoothctl disconnect 3C:4D:BE:89:38:4D";
    dispodso = "(dispods &) && o";

##### Git perso
    dpull = "cd ~/docs && git pull --rebase && cd ~";
    dpush = "cd ~/docs && git add * ; git commit -m '${systemSettings.hostname} commit' && git push";

##### Coding shortcuts
    py = "python3";
    p="clear && python3 *.py";

    j="clear && javac *.java && clear && java Main && echo ''";

    rr="clear && cargo run";
    rb="clear && cargo build";
    rt="clear && cargo test";

    no="cl && node *.js";
};
in
{
    programs = {

        zsh =  {
            enable = true;
            inherit shellAliases;
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

            function v() {
                nvim "$1" || nvim . 
            }

            export PATH=$PATH:$HOME/go/bin

                '';
        };
        bash =  {
            enable = true;
            inherit shellAliases;
        };
        fzf = {
            enable = true;
            enableZshIntegration = true;
            enableBashIntegration = true;
            tmux.enableShellIntegration = true;
        };
    };
}
