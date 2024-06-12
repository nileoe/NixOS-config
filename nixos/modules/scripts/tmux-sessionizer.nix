{pkgs}:
pkgs.writeShellScriptBin "tmux-sessionizer" ''
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/docs ~/docs/coding/rust/ ~/docs/coding/node ~/.config/ ~/docs/coding/ ~/nix-config/ ~/nix-config/home-manager/ ~/nix-config/home-manager/modules/ -mindepth 1 -maxdepth 1 -type d | fzf) # add more paths as necessary fuck yes biach CONTROL FFFFFFF LIKE FIND 
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then
    tmux attach -t $selected_name
else
    tmux switch-client -t $selected_name
fi
''
