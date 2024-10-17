{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    , nix-colors
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
      nixosModules = import ./modules;
      homeManagerModules = (import ../modules/home-manager);
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
          specialArgs = { inherit inputs outputs overlays nix-colors; };
        in
        {
          hiten = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = defaultModules ++ [
              ./machines/hiten/configuration.nix
            ];
          };
          kaguya = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = defaultModules ++ [
              ./machines/kaguya
            ];
          };
        };
    };
}