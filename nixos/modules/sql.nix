{ config, pkgs, ...}:
{
    services.mysql = {
        enable = true;
        package = pkgs.mariadb;
    };
    services.librenms = {
        database.host = "localhost";
        database.username = "nileoe";
    };
}
