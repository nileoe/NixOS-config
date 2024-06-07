{ config, pkgs, ...}:
{
    services.mysql = {
        enable = true;
        packages = pkgs.mariadb;
    };
}
