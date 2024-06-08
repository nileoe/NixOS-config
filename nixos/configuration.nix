# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
    inputs,
        lib,
        config,
        pkgs,
        userSettings,
        systemSettings,
        sessionSettings,
        ...
}:
let
tokyo-night-sddm = pkgs.libsForQt5.callPackage ./modules/ssdm-tokyonight-night/default.nix { };
in {
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };
    services.displayManager.sddm.theme = "tokyo-night-sddm";
    environment.systemPackages = with pkgs; [
        tokyo-night-sddm
        steam-run
        (import ./modules/scripts/startWpRotation.nix {inherit pkgs; })
        (import ./modules/scripts/toggleWaybar.nix {inherit pkgs; })
        (import ./modules/scripts/toggleWallpaper.nix {inherit pkgs; })
        (import ./modules/scripts/changeWallpaper.nix {inherit pkgs; })
    ];
    imports = [
        ./modules/sound-bluetooth-configuration.nix
        ./modules/steam.nix
        ./modules/hyprlandAdditionalPackages.nix
        ./modules/sql.nix
        ./modules/cron.nix
# If you want to use modules from other flakes (such as nixos-hardware):
# inputs.hardware.nixosModules.common-cpu-amd
# inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

# TO ENABLE APPIMAGES AND SUCH generic dynamically linked executables (check safety concerns somewhere and then uncomment)
  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs ; [
  #   ];
  # };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

programs.hyprland.enable = true;

 fonts.packages = with pkgs; [
	nerdfonts
    noto-fonts
    noto-fonts-color-emoji
    corefonts
    garamond-libre
    helvetica-neue-lt-std
    vistafonts
 ];

# environment.systemPackages = [(
#   pkgs.catppuccin-sddm.override {
#     flavor = "mocha";
#     font  = "Noto Sans";
#     fontSize = "9";
#     background = "${./wallpaper.png}";
#     loginBackground = true;
#   }
# )];
# services.displayManager.sddm = {
#   enable = true;
#   theme = "catppuccin-mocha";
# };

 environment.pathsToLink = [
 	"/share/zsh" # to get completion for system packages (e.g. systemd)
 ];
    services.libinput.enable = true;
  time.timeZone = sessionSettings.timeZone;
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
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  networking.hostName = "lix";
networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

 environment.shells = with pkgs; [zsh ] ;  # prlbably not ?
 users.defaultUserShell = pkgs.zsh; # see if necessary
 programs.zsh.enable = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.fullName;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
      openssh.authorizedKeys.keys = [];
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
