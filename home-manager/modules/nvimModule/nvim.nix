{ config, pkgs, ...}:
{
	xdg.configFile.nvim.source = ./nvim;
}
# Neovim config is NOT managed by nix: this module is NOT loaded (would be for a fully declarative Neovim configuration).
# REMOVED DIRECTORY: intially the standard ./nvim directory (containing init.lua and everything else) was in the nvimModule directory.
# made it its separate repo in ~/.config/nvim instead (managed separately).
