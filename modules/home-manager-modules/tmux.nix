# more complex config: seel
# https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-Space";
    clock24 = true;
    sensibleOnTop = true; # sensible defaults can be overriden in extraCongig
    keyMode = "vi";
    baseIndex = 1;
    historyLimit = 10000;

    escapeTime = 0;

    plugins = with pkgs; [
      tmuxPlugins.sensible

      tmuxPlugins.better-mouse-mode
      tmuxPlugins.jump
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.mode-indicator
      tmuxPlugins.tmux-fzf
      tmuxPlugins.yank # y and Y
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        # extra config at the end of main extraConfig to use the status-right tmux variable
        extraConfig = ''
        '';
      }
    ];

    # The code inside extraConfig is ran after the declared options, which
    # can be useful if some code / plugin is dependent on something else.
    extraConfig = ''
            bind S command-prompt -p "New Session:" "new-session -A -s '%%'"
            bind K confirm kill-session
            bind r source-file ~/.config/tmux/tmux.conf
      set-option -g renumber-windows
      # unbind-key f
      bind-key -r f run-shell "tmux neww tmux-sessionizer"
      # set-option -g status-position bottom
      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"
      # bind "C-q" contiinuum save or something && kill-session

            # TokyoNight colors for Tmux (not in home-manager as of yet)

             set -g mode-style "fg=#7aa2f7,bg=#3b4261"

             set -g message-style "fg=#7aa2f7,bg=#3b4261"
             set -g message-command-style "fg=#7aa2f7,bg=#3b4261"

             set -g pane-border-style "fg=#3b4261"
             set -g pane-active-border-style "fg=#7aa2f7"

             set -g status "on"
             set -g status-justify "left"

             set -g status-style "fg=#7aa2f7,bg=#16161e"

             set -g status-left-length "100"
             set -g status-right-length "100"

             set -g status-left-style NONE
             set -g status-right-style NONE

             set -g status-left "#[fg=#15161e,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#16161e,nobold,nounderscore,noitalics]"
             set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h "
             if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "24" ]' {
                 set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h "
             }

            setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#16161e"
            setw -g window-status-separator ""
            setw -g window-status-style "NONE,fg=#a9b1d6,bg=#16161e"
            setw -g window-status-format "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]"
            setw -g window-status-current-format "#[fg=#16161e,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]"

            # tmux-plugins/tmux-prefix-highlight support
            set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#16161e]#[fg=#16161e]#[bg=#e0af68]"
            set -g @prefix_highlight_output_suffix ""


            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '2' # minutes (default 15)
    '';
  };
}
