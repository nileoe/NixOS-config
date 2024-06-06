{ config, pkgs, ...}:
{
	xdg.configFile.nvim.source = ./nvim;
}
# fix with https://discourse.nixos.org/t/neovim-config-read-only/35109/11 mkOufOfSToreSmLink comment
