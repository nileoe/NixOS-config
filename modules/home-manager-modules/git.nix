{
  config,
  pkgs,
  userSettings,
  ...
}: {
  home.packages = with pkgs; [
    github-desktop
    gitkraken
  ];

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      pull.rebase = "true";
      user = {
        email = userSettings.email;
        name = userSettings.username;
      };
    };
  };
}
