{
  description = "Dotfiles-BASH";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = with pkgs; mkShell {
        buildInputs = [ shfmt shellcheck ];
      };
    };
}
