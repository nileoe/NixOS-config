{
    description = "FlakeyFlakey";

    inputs = {
        # Nixpkgs
        # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	# saturnCursorTheme = "path:/home/nileoe/Downloads/Saturn/"


        # Home manager
        # home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.url = "github:nix-community/home-manager/";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        # catppuccin.url = "github:catppuccin/nix";

        # dev_specific_config = {
        #     url = "path:./device-specific/";
        #     flake = false;
        # };

    };

    outputs = {
        self,
        nixpkgs,
        nixpkgs-unstable,
        home-manager,
        ...
    } @ inputs: let
    inherit (self) outputs;
    userSettings = (import /etc/nixos/settings.nix).userSettings;
    systemSettings = (import /etc/nixos/settings.nix).systemSettings;
    sessionSettings = (import /etc/nixos/settings.nix).sessionSettings;
    # settings = import "${inputs.dev_specific_config}/settings.nix";
    # userSettings = settings.userSettings;
    # systemSettings = settings.systemSettings;
    # sessionSettings = settings.sessionSettings;
    # hardwareConfiguration = import "${inputs.dev_specific_config}/hardwareConfiguration.nix"; # does not work for some reason
    in {
    # rest of the flake configuration
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = {
            "${systemSettings.hostname}" = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs; inherit systemSettings; inherit userSettings; inherit sessionSettings;}; # inherit hardwareConfiguration; 
                # > Our main nixos configuration file <
                modules = [./nixos/configuration.nix];
            };
        };

        # Standalone home-manager configuration entrypoint
        # Available through 'home-manager --flake .#your-username@your-hostname'
        homeConfigurations = {
            "${userSettings.username}@${systemSettings.hostname}" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
                    extraSpecialArgs = {inherit inputs outputs; inherit userSettings; inherit systemSettings; inherit sessionSettings;};
                # > Our main home-manager configuration file <
                modules = [./home-manager/home.nix];
            };
        };
    };
}
