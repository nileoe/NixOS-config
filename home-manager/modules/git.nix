{config, pkgs, userSettings, ...}:
{
    home.packages = with pkgs; [
        github-desktop
        gitkraken
    ];

    programs.git = {
        enable = true;
        userName = userSettings.username;
        userEmail =  userSettings.email;
        extraConfig = {
            init.defaultBranch = "main";
            core.editor = "nvim";
            pull.rebase = "true";
        };
    };
}
