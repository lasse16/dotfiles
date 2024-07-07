{
  description = "My NixOS-WSL setup";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
	inherit system;
        specialArgs = {inherit system;};

        modules = [./configuration.nix];
      };
    };
  };
}
