{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , nixos-hardware
    , home-manager
    , agenix
    , ...
    }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "aarch64-linux" "x86_64-linux" ];
      defaultOverlay = import ./overlay/default.nix;
      overlays = [
        agenix.overlays.default
        (final: prev: {
          unstable = nixpkgs-unstable.legacyPackages.${prev.system};
          inherit (nixpkgs-unstable.legacyPackages.${prev.system}) neovim-unwrapped;
        })
        defaultOverlay
      ];
      nixosModules = import ./modules/nixos;
      homeManagerModules = (import ./home-manager/modules);
      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit legacyPackages nixosModules homeManagerModules;
      overlays.default = defaultOverlay;

      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);

      templates = import ./templates;

      nixosConfigurations =
        let
          defaultModules = (builtins.attrValues nixosModules) ++ [
            agenix.nixosModules.default
            home-manager.nixosModules.default
          ];
          specialArgs = { inherit inputs outputs overlays; };
        in
        {
          hiten = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = defaultModules ++ [
              ./nixos/hiten
            ];
          };
          kaguya = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = defaultModules ++ [
              ./nixos/kaguya
            ];
          };
        };

    };
}
