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
    ./homeModules/hypr/hyprland.nix
    ./homeModules/kitty.nix
    # ./homeModules/nvim.nix
    ./homeModules/sh.nix
    ./homeModules/speedcrunch.nix
    ./homeModules/waybar/waybar.nix
    ./homeModules/tmux.nix
    ./homeModules/zoxide.nix
    ./homeModules/zsh.nix
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
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "nileoe"; # TODO use variables for these 2 lines
    homeDirectory = "/home/nileoe";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    neovim
    cider
    # kitty
    fzf
    sl
    firefox
    neofetch
    cinnamon.nemo-with-extensions
    rofi
    # tmux # done through module
    htop
    git
    tree
    bat
    steam
    scarab
    # haskellPackages.battlenet
    killall
    librewolf
    cmatrix
    obsidian
    _1password-gui
    _1password
    microsoft-edge
    vscode
    # xclip
    # xsel
    wl-clipboard
zapzap
whatsapp-for-linux
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
