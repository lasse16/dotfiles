{
  description = "Dotfiles-NVIM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    dev-envs = {
      url = "github:lasse16/dev-envs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    dev-envs,
  }: let
    system = "x86_64-linux";
  in {
    devShells.${system}.default = dev-envs.devShells.${system}.lua;
  };
}
