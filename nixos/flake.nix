{
  description = "My NixOS-WSL setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-neovim.url = "github:nixos/nixpkgs/nixos-25.11";
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
