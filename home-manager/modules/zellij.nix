{ config, pkgs, ...}:
{
    programs.zellig = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;

        settings = {
        };
    };
}
