{config, pkgs, ...}:
{
    home.packages = with pkgs; [
        github-desktop
        gitkraken
    ];

    programs.git = {
        enable = true;
        userName = "nileoe";
        userEmail = "linoperdrix@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
            core.editor = "nvim";
            pull.rebase = "true";
        };
    };
}
