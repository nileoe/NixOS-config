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
    ])
  ];

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    channel.enable = false;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # older config (may be useful for dualbooting with grun?)
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.useOSProber = true; # uncomment for no dual-boot
  # boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = userSettings.hostname;
  networking.networkmanager.enable = true;

  #  networking.wireless.networks.eduroam = {
  # auth = ''
  #       key_mgmt=WPA-EAP
  #       eap=PWD
  #       identity="k2232947@kingston.ac.uk"
  #       password="'Si m1 la re sol do fa"
  #       '';
  #  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;

  # hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # WLR_NO_HARDWARE_CURSORS = "1"; # avoid invisible cursor # CHECK if needed
  # gtk.iconCache.enable = true; # ????

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "tokyo-night-sddm";
  };

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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # TO ENABLE APPIMAGES and other such generic dynamically linked executables
  programs.nix-ld.enable = true;
  programs.nix-ld.package = pkgs.nix-ld-rs;

  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-color-emoji
    corefonts
    garamond-libre
    helvetica-neue-lt-std
    vistafonts
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # TODO remove at some point
  nixpkgs.config.permittedInsecurePackages = [
    "electron-30.5.1"
  ];

  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  #############################################################################################################
  ################################################## TESTING ##################################################
  #############################################################################################################

  # home-manager.users.nileoe = {
  #   dconf.settings = {
  #     "org/gnome/desktop/background" = {
  #       picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
  #     };
  #     "org/gnome/desktop/interface" = {
  #       color-scheme = "prefer-dark";
  #     };
  #   };
  #
  #   gtk = {
  #     enable = true;
  #     theme = {
  #       name = "Adwaita-dark";
  #       package = pkgs.gnome.gnome-themes-extra;
  #     };
  #   };
  #
  #   # Wayland, X, etc. support for session vars
  #   systemd.user.sessionVariables = config.home-manager.users.nileoe.home.sessionVariables;
  # };
  #
  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };

  #############################################################################################################
  #############################################################################################################
  #############################################################################################################

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
