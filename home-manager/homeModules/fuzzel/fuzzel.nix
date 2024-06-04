{ config, pkgs, ...}:
{
	programs.fuzzel = {
		enable = true;
	};
	home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;

}
