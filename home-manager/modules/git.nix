{config, pkgs, ...}:
{
    home.packages = [ pkgs.github-desktop ];

    programs.git = {
        enable = true;
        userName = "nileoe";
        userEmail = "linoperdrix@gmail.com";
    };
}
