{ config, pkgs, userSettings, ...}:
let 
shellAliases = {
##### Basic commands / simple navigation
    cat = "bat -p --theme 'Nord'";
    catt = "bat --theme 'Nord'";
    cl = "clear";
    o = "exit";
    ":q" = "exit";
    # tl = "tree -L";# TODO remove if eza is kept
    gf = "fg";
    gr = "grep --colour=auto";
    gri = "grep -i --colour=auto";
    cp = "cp -i";
    mv = "mv -i";
    rm = "rm -i";
    wlc = "wl-copy";
    wlp = "wl-paste";
    cw = "change_wallpaper";
    open = "xdg-open";

    ##### RIP ls
    ls = "eza";
    ll = "eza -l --header";
    la = "ls -a";
    tl = "eza --tree --level"; # expects a number as depth level
    tre = "eza -T";
    sl = "sl -e"; # :)

##### Navigation and fzbvvbvbbvvv
    cd = "z"; # zzzzzzzoxide
    ".1" = "cd ..";
    ".2" = ".1 && cd ..";
    ".3" = ".2 && cd ..";
    ".4" = ".3 && cd ..";
    ".5" = ".4 && cd ..";
    # fzv = "nvim $(fzf --reverse)";
    # "fi"="fzv";
    fzb = "fzf --reverse --preview 'bat --style=numbers --color=always {}'";
    fzvb = "nvim $(fzb)";
    fzbv = "fzvb";

##### NixOS
 #   hswitch= "cd ~/nix-config && home-manager switch --flake .#${userSettings.username}@${userSettings.hostname} --impure && notify-send 'home-manager switch complete.'";
 #   nswitch = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#${userSettings.hostname} --impure && notify-send 'nixos-rebuilt switch complete'";
    switch = "cd ~/nixos/ && sudo nixos-rebuild switch --impure --flake .#${userSettings.hostname} && notify-send 'NixOS' 'Switch complete'";
    switcho = "switch && o";
    switchcd = "switch && cd && cl";
    switchrel = "switch && hyprctl reload";
    gho = "Hyprland";


##### Miscellaneous
# replace / remove as needed
    airpods = "dispods; bluetoothctl connect 3C:4D:BE:89:38:4D && clear";
    airpodso = "(airpods &) && o";
    dispods = "bluetoothctl disconnect 3C:4D:BE:89:38:4D && clear";
    dispodso = "(dispods &) && o";
    boom = "disboom; bluetoothctl connect 10:94:97:2B:E5:39 && clear";
    boomo = "(boom &) && o";
    disboom = "bluetoothctl disconnect 10:94:97:2B:E5:39 && clear";
    disboomo = "(disboom &) && o";

##### Git custom docs shortcuts, remove as needed
    dpull = "cd ~/docs && git pull --rebase && cd ~";
    dpush = "cd ~/docs && git add * ; git commit -m '${userSettings.hostname} (${userSettings.monitorType}) commit' && git push";

##### Coding shortcuts
    g = "git";
    G = "g";
    py = "python3";
    p="clear && python3 *.py";

    j="clear && javac *.java && clear && java Main && echo ''";

    rr="clear && cargo run";
    rb="clear && cargo build";
    rt="clear && cargo test";

    no="cl && node *.js";

    mdb="mariadb -u lino -p";
    ##### temp
    clicker = "sudo /home/nileoe/.cargo/bin/theclicker -l 274 --no-grab";
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

            source ${./zellij-basic-completion.zsh}

            export PATH=$PATH:$HOME/go/bin
            export EDITOR="nvim"
      export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
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
