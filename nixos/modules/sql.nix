{ config, pkgs, userSettings, ...}:
{
    services.mysql = {
        enable = true;
        package = pkgs.mariadb;
    };
    services.librenms = {
        database.host = "localhost";
        database.username = userSettings.username;
    };
}
