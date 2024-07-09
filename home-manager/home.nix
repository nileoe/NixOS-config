# credit to https://github.com/Misterio77/nix-starter-configs for the base structure
# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
    inputs,
    lib,
    config,
    pkgs,
    userSettings,
    systemSettings,
    sessionSettings,
    ...
}: {
# You can import other home-manager modules here
    imports = [
# If you want to use home-manager modules from other flakes (such as nix-colors):
# inputs.nix-colors.homeManagerModule

# You can also split up your configuration and import pieces of it here:
        ./modules/hypr/hyprland.nix
        ./modules/additionalBluetoothConfig.nix
        ./modules/fuzzel/fuzzel.nix
        ./modules/kitty.nix
        ./modules/libreoffice.nix
        ./modules/mako.nix
        # ./modules/nvimModule/nvim.nix # for declarative Neovim configuration (unused)
        ./modules/shell/sh.nix
        ./modules/speedcrunch.nix
        ./modules/waybar/waybar.nix
        # ./modules/tmux.nix
        ./modules/zellij/zellij.nix
        ./modules/zoxide.nix
        ./modules/gtk.nix
        ./modules/git.nix

        inputs.catppuccin.homeManagerModules.catppuccin
    ];



    nixpkgs = {
# You can add overlays here
        overlays = [
# If you want to use overlays exported from other flakes:
# neovim-nightly-overlay.overlays.default

# Or define it inline, for example:
# (final: prev: {
#   hi = final.hello.overrideAttrs (oldAttrs: {
#     patches = [ ./change-hello-to-hi.patch ];
#   });
# })
        ];

# Configure your nixpkgs instance
        config = {
            allowUnfree = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
            allowUnfreePredicate = _: true;
        };
    };

    home = {
        username = userSettings.username;
        homeDirectory = "/home/${userSettings.username}";
    };

# Add stuff for your user as you see fit:
    home.packages = with pkgs; [
    # feel free to add/remove/comment
        localsend
        _1password-gui
        _1password
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
        whatsapp-for-linux
        # discord
        vesktop # discord (vencord) wrapper that allows for screen share with audio on wayland
# Gaming
        prismlauncher # aka FOSS minecraft launcher
        scarab        # Hollow Knight mod manager
        sssnake
        # slipstream    # FTL mod manager
# Browsers
        microsoft-edge
        librewolf
        firefox
        chromium
        google-chrome
        tridactyl-native
# Note taking
        obsidian
        remnote
        anki
        zegrapher
# coding
        neovim
        vscode # :)
        neovide
# programming languages and frameworks
        nodejs_22
        clang
        libgcc
        rustc
        python3
        go
        cargo
        rustc
        jdk
        octaveFull
# CLI tools
        kooha
        wget
        eza
        speedtest-rs
        neofetch
        gh
        acpi
        cmatrix
        sl
        lolcat
        grimblast
        playerctl
        htop
        tree
        bat
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
# File managers
        kdePackages.dolphin
        kdePackages.dolphin-plugins
        pcmanfm
        gnome.nautilus
        cinnamon.nemo-with-extensions
# PDF/Image readers
        zathura
        kdePackages.okular
        mate.atril
        mupdf
        # feh
# Music
        cider
        reaper
        musescore
        audacity
        ];

    programs.home-manager.enable = true;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "24.05";
}
