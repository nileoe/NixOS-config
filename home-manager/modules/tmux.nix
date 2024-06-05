# more complex config: seel
# https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
{ config, pkgs, ...}:
let
theme = "poire";
in
{
	programs.tmux = {
		enable = true;
		mouse = true;
		prefix = "C-Space";
		clock24 = true;
		sensibleOnTop = true; # sensible defaults can be overriden in extraCongig
		keyMode = "vi"; # ???????????????
		baseIndex = 1;
		historyLimit = 10000;

		escapeTime = 0;

 	 	plugins = with pkgs; [
 	 		tmuxPlugins.sensible
  	 		# tmuxPlugins.gruvbox
            tmuxPlugins.nord
            # tmuxPlugins.catppuccin
		#	{
			# plugin = tmuxPlugins.catppuccin;
		# 	extraConfig = ''
		# 	# catppuccin config https://github.com/catppuccin/tmux?tab=readme-ov-file#configuration-examples
		# 	# see https://github.com/tmux/tmux/wiki/Formats
		# 	# https://man.openbsd.org/tmux.1#FORMATS

		# 	set -g @catppuccin_window_left_separator "█"
		# 	set -g @catppuccin_window_right_separator "    " # space between windows in bar
		# 	set -g @catppuccin_window_number_position "left"
		# 	set -g @catppuccin_window_middle_separator "█ "

		# 	set -g @catppuccin_window_current_fill "number"
		# 	set -g @catppuccin_window_current_text "#W"
		# 	set -g @catppuccin_window_default_fill "number"
		# 	set -g @catppuccin_window_default_text "#W"
		# 	# set -g @catppuccin_window_current_text "#W : #{pane_current_path}"

		# 	set -g @catppuccin_status_modules_right "session date_time"

		# 	# catppuccin status
		# 	set -g @catppuccin_status_left_separator  "█"
		# 	set -g @catppuccin_status_right_separator "█"
		# 	set -g @catppuccin_status_fill "all"
		# 	set -g @catppuccin_status_connect_separator "yes"
		# 	'';
		# 	}
 	 		tmuxPlugins.better-mouse-mode
 	 		tmuxPlugins.jump
 	 		tmuxPlugins.vim-tmux-navigator
 	 		tmuxPlugins.mode-indicator
			tmuxPlugins.tmux-fzf
			tmuxPlugins.yank # y and Y
 			{
 				plugin = tmuxPlugins.resurrect;
 				# extraConfig = "set -g @resurrect-strategy-nvim 'session'";
 			}
			{
				plugin = tmuxPlugins.continuum;
				extraConfig = ''
					set -g @continuum-restore 'on'
					set -g @continuum-save-interval '5' # minutes (default 15)
					'';
			}
 		];
	
	# source-file '/home/nil_/.config/tmux/semi_straight_catppuccin.conf'

		# The code inside extraConfig is ran after the declared options, which
		# can be useful if some code / plugin is dependent on something else.
		extraConfig = ''
        bind o display "It's all gonna be ok"
        bind S command-prompt -p "New Session:" "new-session -A -s '%%'"
        bind K confirm kill-session
        bind r source-file ~/.config/tmux/tmux.conf
		set-option -g renumber-windows
		# unbind-key f
		bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"
		# set-option -g status-position bottom
		bind '"' split-window -v -c "#{pane_current_path}"
		bind '%' split-window -h -c "#{pane_current_path}"
		# bind "C-q" contiinuum save or something && kill-session

        # thanks internet, makes it so that C-j/k work in fzf in tmux
         not_tmux='`echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?x?)(diff)?$"` || `echo "#{pane_current_command}" | grep -iqE "(^|\/)fzf"`'
         bind-key -n C-h if-shell "$not_tmux" "send-keys C-h" "select-pane -L"
         bind-key -n C-j if-shell "$not_tmux" "send-keys C-j" "select-pane -D"
         bind-key -n C-k if-shell "$not_tmux" "send-keys C-k" "select-pane -U"
         bind-key -n C-l if-shell "$not_tmux" "send-keys C-l" "select-pane -R"
		'';

	};
}
