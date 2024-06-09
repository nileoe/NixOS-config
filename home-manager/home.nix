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
        ./modules/nvimModule/nvim.nix
        ./modules/sh.nix
        ./modules/speedcrunch.nix
        ./modules/waybar/waybar.nix
        ./modules/tmux.nix
        ./modules/zoxide.nix
        ./modules/graphical-file-managers.nix
        ./modules/gtk.nix

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
        brightnessctl
        # gnome.adwaita-icon-theme
        clang
        libgcc
        cider
        cargo
        discord
        neovim
        nodejs_22
        pamixer
        playerctl
        localsend
        github-desktop
        rustc
        dbus
        acpi
        eww
        sl
        firefox
        neofetch
        rofi
        python3
        htop
        tree
        bat
        scarab
        python312Packages.simplenote
        grimblast
        killall
        librewolf
        cmatrix
        obsidian
        _1password-gui
        _1password
#        microsoft-edge
#        fira-mono
        speedtest-cli
        speedtest-rs
        remnote
        vscode
        wl-clipboard
        whatsapp-for-linux
        zip
        unzip
        zapzap
        swww
        alacritty
        networkmanagerapplet
        lolcat
        cowsay
# file managers
        kdePackages.dolphin
        kdePackages.dolphin-plugins
        pcmanfm
        gnome.nautilus
        cinnamon.nemo-with-extensions
# PDF readers
        zathura
        kdePackages.okular
        mate.atril
        mupdf
        feh
        ];

    programs.home-manager.enable = true;
    programs.git = {
        enable = true;
        userName = "nileoe";
        userEmail = "linoperdrix@gmail.com";
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "24.05";
}
