{ config, pkgs, ...}:
{
	xdg.configFile.nvim.source = ./nvim; # worked (kinda)
}
# fix with https://discourse.nixos.org/t/neovim-config-read-only/35109/11 mkOufOfSToreSmLink comment
# REMOVED DIRECTORY: intially the standard nvim directory (containing init.lua and everything else) was in the nvimModule directory
# made it its separate repo in ~/.config/nvim instead (managed separately)
