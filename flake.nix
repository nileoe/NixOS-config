{
  description = "Your (mostly) own NixOS configuration!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    # The `follows` keyword in inputs is used for inheritance.
    # Here, `inputs.nixpkgs` of home-manager is kept consistent with
    # the `inputs.nixpkgs` of the current flake,
    # to avoid problems caused by different versions of nixpkgs.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: let
    userSettings = (import /etc/nixos/settings.nix).userSettings;
    hardwareConfiguration = (import /etc/nixos/hardware-configuration.nix); in
  {

    nixosConfigurations = {
      ${userSettings.hostname} = nixpkgs.lib.nixosSystem { # hostname
        system = "x86_64-linux";
        specialArgs = { inherit inputs userSettings; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
	  hardwareConfiguration
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nileoe = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            home-manager.extraSpecialArgs = { inherit userSettings; };
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
