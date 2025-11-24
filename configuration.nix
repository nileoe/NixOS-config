{
  config,
  lib,
  pkgs,
  userSettings,
  inputs,
  ...
}: let
  tokyo-night-sddm = pkgs.libsForQt5.callPackage ./modules/nixos-modules/ssdm-tokyonight-night/default.nix {};
in {
  home-manager.backupFileExtension = "backup";
  imports = [
    ./modules/nixos-modules/sound-bluetooth-configuration.nix
    ./modules/nixos-modules/steam.nix
    ./modules/nixos-modules/sql.nix
    # ./modules/nixos-modules/cron.nix
  ];

  environment.systemPackages = lib.mkMerge [
    (import ./modules/home-manager-modules/shell/scripts.nix {inherit pkgs;})
    (with pkgs; [
      tokyo-night-sddm
      steam-run
      inputs.zen-browser.packages."${system}".default
    ])
  ];

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    channel.enable = false;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  virtualisation.docker = {
    enable = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = userSettings.hostname;
  networking.networkmanager.enable = true;

  console = {
    keyMap = "uk";
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;

  # hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  hardware.keyboard.zsa.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "tokyo-night-sddm";
  };
  services.gvfs.enable = true;

  time.timeZone = userSettings.timeZone;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # TO ENABLE APPIMAGES and other similar generic dynamically linked executables
  programs.nix-ld.enable = true;

  fonts.packages = with pkgs;
    [
      cascadia-code
      # nerdfonts
      noto-fonts
      noto-fonts-color-emoji
      corefonts
      garamond-libre
      helvetica-neue-lt-std
      vistafonts
      open-sans
      lora
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  nixpkgs.config.allowUnfree = true;

  # TODO remove when not necessary anymore
  nixpkgs.config.permittedInsecurePackages = [
    "electron-30.5.1"
    "electron-32.3.3"
  ];

  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };
  system.stateVersion = "24.11";
}
