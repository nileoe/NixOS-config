{ config, pkgs, ...}:
{
    programs.zellij = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;

        settings = {
        };
    };
}
