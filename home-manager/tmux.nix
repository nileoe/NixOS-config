{ config, pkgs, ...}:
{
	programs.tmux = {
		enable = true;
		mouse = true;
		prefix = "c-a";
	};
}
