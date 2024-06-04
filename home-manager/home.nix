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
          ./modules/fuzzel/fuzzel.nix
          ./modules/kitty.nix
          ./modules/nvimModule/nvim.nix
          ./modules/sh.nix
          ./modules/speedcrunch.nix
          ./modules/waybar/waybar.nix
          ./modules/tmux.nix
          ./modules/zoxide.nix
          ./modules/zsh.nix
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
  clang
    libgcc
    cider
    cargo
    discord
    neovim
    nodejs_22
    pamixer
    playerctl
    fzf
    sl
    firefox
    neofetch
    cinnamon.nemo-with-extensions
    rofi
    python3
    htop
    git
    tree
    bat
    steam
    scarab
    killall
    librewolf
    cmatrix
    obsidian
    _1password-gui
    _1password
    microsoft-edge
    remnote
    vscode
    wl-clipboard
	whatsapp-for-linux
    zip
    unzip
	zapzap
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
