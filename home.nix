{
  config,
  pkgs,
  userSettings,
  ...
}: {
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # You can also split up your configuration and import pieces of it here:
    ./modules/home-manager-modules/hypr/hyprland.nix
    ./modules/home-manager-modules/additionalBluetoothConfig.nix
    ./modules/home-manager-modules/fuzzel/fuzzel.nix
    ./modules/home-manager-modules/kitty.nix
    ./modules/home-manager-modules/libreoffice.nix
    ./modules/home-manager-modules/mako.nix
    # ./modules/home-manager-modules/nvimModule/nvim.nix # for declarative Neovim configuration (unused)
    ./modules/home-manager-modules/shell/sh.nix
    ./modules/home-manager-modules/speedcrunch.nix
    ./modules/home-manager-modules/waybar/waybar.nix
    # ./modules/home-manager-modules/tmux.nix
    ./modules/home-manager-modules/zellij/zellij.nix
    ./modules/home-manager-modules/zoxide.nix
    ./modules/home-manager-modules/gtk.nix
    ./modules/home-manager-modules/git.nix
    # inputs.catppuccin.homeManagerModules.catppuccin
  ];

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # TESTING sort/decide if keeping or not
    postman
    appimage-run
    gnumake
    juce
    powershell
    warp
    morgen
    kdePackages.korganizer
    evolution
    calcurse
    osmo
    gnome-calendar
    clang
    clang-tools
    cmake

    # feel free to add/remove/comment
    localsend
    _1password-gui
    _1password-cli
    swww
    networkmanagerapplet
    alacritty

    # System helpers
    eww
    pamixer
    dbus
    pulseaudioFull
    qpwgraph
    exfat
    gptfdisk

    # Social
    caprine-bin
    whatsapp-for-linux
    zoom-us
    # vesktop # discord (vencord) wrapper that allows for screen share with audio on wayland
    discord

    # Gaming
    bsdgames
    prismlauncher # FOSS minecraft launcher
    scarab # Hollow Knight mod manager
    sssnake
    lutris
    kmonad

    # Browsers
    microsoft-edge
    librewolf
    firefox
    chromium
    google-chrome
    tor-browser

    # Note taking and writing
    obsidian
    remnote
    anki
    zegrapher
    iotas
    zotero_7

    # coding
    neovim
    neovide
    vscode
    jetbrains.clion
    jetbrains.rust-rover
    jetbrains.webstorm
    jetbrains.webstorm
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    wezterm
    netbeans

    # programming languages/frameworks, LSP/Formatters
    libgccjit
    putty
    nodejs_22
    php
    libgcc
    rustc
    python3
    go
    cargo
    rustc
    jdk
    octaveFull
    maven
    lua
    luajitPackages.luarocks-nix
    typescript
    alejandra
    nixd
    # pkgs.python312Packages.debugpy

    # CLI tools
    yt-dlp
    evtest
    lsof
    jq
    wev
    kooha
    wget
    eza
    speedtest-rs
    neofetch
    gh
    acpi
    ffmpeg
    fzf
    cmatrix
    lolcat
    playerctl
    htop
    tree
    bat
    ripgrep
    killall
    speedtest-cli
    wl-clipboard
    zip
    unzip
    brightnessctl
    file
    unixtools.xxd
    pkg-config
    glib
    ventoy

    # File managers
    virtualbox
    yazi
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    pcmanfm
    nautilus
    nemo-with-extensions
    torrential

    # PDF/Image readers / graphic tools
    zathura
    kdePackages.okular
    mate.atril
    mupdf
    eyedropper
    drawio
    feh

    # Video and music
    grimblast
    obs-studio
    wayfarer
    vlc
    # haruna
    cider
    reaper
    musescore
    audacity

    nnn # terminal file manager

    # archives
    xz
    # p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    # yq-go # yaml processor https://github.com/mikefarah/yq

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    which
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # # starship - an customizable prompt for any shell
  # programs.starship = {
  #   enable = true;
  #   # custom settings
  #   settings = {
  #     add_newline = false;
  #     aws.disabled = true;
  #     gcloud.disabled = true;
  #     line_break.disabled = true;
  #   };
  # };

  # # alacritty - a cross-platform, GPU-accelerated terminal emulator
  # programs.alacritty = {
  #   enable = true;
  #   # custom settings
  #   settings = {
  #     env.TERM = "xterm-256color";
  #     font = {
  #       size = 12;
  #       draw_bold_text_with_bright_colors = true;
  #     };
  #     scrolling.multiplier = 5;
  #     selection.save_to_clipboard = true;
  #   };
  # };

  # programs.bash = {
  #   enable = true;
  #   enableCompletion = true;
  #   # TODO add your custom bashrc here
  #   bashrcExtra = ''
  #     export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
  #   '';
  #   # set some aliases, feel free to add more or remove some
  #   shellAliases = {
  #     k = "kubectl";
  #     urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
  #     urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  #   };
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
