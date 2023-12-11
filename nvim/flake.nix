{
  description = "Dotfiles-NVIM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = with pkgs; mkShell {
        buildInputs = [ lua-language-server ];
	DEV_SHELL = "DOTFILES-NVIM";
      };
    };
}
