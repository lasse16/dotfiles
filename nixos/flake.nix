{
  description = "My NixOS-WSL setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-neovim.url = "github:nixos/nixpkgs/4a29d733e8a7d5b824c3d8c958a946a9867b3eb2"; # v 0.12.2
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-neovim,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    pkgs-neovim = import nixpkgs-neovim {inherit system;};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit system pkgs-neovim;};

        modules = [./configuration.nix];
      };
    };
  };
}
