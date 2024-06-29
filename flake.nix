{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      devarsh-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./devices/devarsh-desktop
          ./nixosModules
          inputs.home-manager.nixosModules.default
        ];
      };
      devarsh-slg = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./devices/devarsh-slg
          ./nixosModules
          inputs.home-manager.nixosModules.default
        ];
      };
    };

    homeManagerModules.default = ./homeManagerModules;
  };
}
