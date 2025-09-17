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
    ./modules/home-manager-modules/desktopEntries.nix
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

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # TESTING sort/decide if keeping or not
    # fontconfig
    # dconf-editor
    # appimage-run
    # gnumake
    # powershell
    # warp
    # morgen
    # kdePackages.korganizer
    # evolution
    # calcurse
    # osmo
    # gnome-calendar
    hplip

    # ZSA Voyager
    keymapp
    eudev

    # feel free to add/remove/comment out
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
    discord

    # Gaming
    prismlauncher # FOSS minecraft launcher
    scarab # Hollow Knight mod manager
    bsdgames
    sssnake
    lutris # Battlenet and more

    # Browsers
    # microsoft-edge
    librewolf
    firefox
    chromium
    google-chrome
    tor-browser

    # Note taking and writing
    obsidian
    remnote
    anki-bin
    # zegrapher
    iotas
    zotero_7

    # coding
    neovim
    neovide
    postman
    vscode
    # jetbrains.clion
    # jetbrains.rust-rover
    # jetbrains.webstorm
    # jetbrains.webstorm
    # jetbrains.idea-ultimate
    # jetbrains.pycharm-professional
    wezterm
    netbeans

    # programming languages/frameworks, LSP/Formatters
    clang
    clang-tools
    cmake
    # libgccjit
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
    juce
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
    # ventoy

    # File managers
    virtualbox
    yazi
    pcmanfm
    nautilus
    sushi
    torrential

    # PDF/Image readers / graphic tools
    zathura
    kdePackages.okular
    mate.atril
    mupdf
    eyedropper
    drawio
    feh
    masterpdfeditor

    # Video and music
    grimblast
    obs-studio
    wayfarer
    vlc
    # haruna
    cider-2
    spotify
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

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
