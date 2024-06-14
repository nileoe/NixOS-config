{
    description = "lixing";

    inputs = {
# Nixpkgs
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

# Home manager
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        catppuccin.url = "github:catppuccin/nix";

        dev_specific_config = {
            url = "path:./device-specific/";
            flake = false;
        };

    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        ...
    } @ inputs: let
    inherit (self) outputs;
    # userSettings = (import ./settings.nix).userSettings;
    # systemSettings = (import ./settings.nix).systemSettings;
    # sessionSettings = (import ./settings.nix).sessionSettings;
    settings = import "${inputs.dev_specific_config}/settings.nix";
    userSettings = settings.userSettings;
    systemSettings = settings.systemSettings;
    sessionSettings = settings.sessionSettings;
    hardwareConfiguration = import "${inputs.dev_specific_config}/hardware-configuration.nix"; # does not work for some reason
    in {
    # rest of the flake configuration
# NixOS configuration entrypoint
# Available through 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = {
            lix = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs; inherit hardwareConfiguration inherit systemSettings; inherit userSettings; inherit sessionSettings;}; 
# > Our main nixos configuration file <
                modules = [./nixos/configuration.nix];
            };
        };

# Standalone home-manager configuration entrypoint
# Available through 'home-manager --flake .#your-username@your-hostname'
        homeConfigurations = {
# "nileoe@lix" = home-manager.lib.homeManagerConfiguration {
    "${userSettings.username}@${systemSettings.hostname}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
            extraSpecialArgs = {inherit inputs outputs; inherit userSettings; inherit systemSettings; inherit sessionSettings;};
# > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
    };
};
};
}
