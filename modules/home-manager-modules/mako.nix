{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify
  ];
  services.mako = {
    enable = true;
    settings = {
      ignore-timeout = true;
      default-timeout = 10000; # in miliseconds
      border-radius = 2;
      border-color = "#FBFBFE";
      border-size = 1;
      background-color = "#2B2A33";
      text-color = "#FBFBFE";
    };
  };
}
