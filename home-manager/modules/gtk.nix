{config, pkgs, ...}:
{
    home.packages = with pkgs; [
    ];
    gtk = {
        enable = false;
    };
}
