{
  description = "my overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
  };


  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          self.overlays.default
        ];
      };
    in
    {
      bar = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit nix-colors; };
      };
      overlays.default = final: prev: {
        modules = { };
      };
    };
}
