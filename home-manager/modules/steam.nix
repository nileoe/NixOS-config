{config, pkgs, ...}:
{
    home.packages.pkgs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };
    # pkgs.protonup-qt
}
