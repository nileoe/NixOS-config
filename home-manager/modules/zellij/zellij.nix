{ config, pkgs, ...}:
{
    programs.zellij = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;

        settings = {
        };
    };

	home.file.".config/zellij/config.kdl".source = ./config.kdl;
}
