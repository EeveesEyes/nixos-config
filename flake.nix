{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      agenix,
      nix-colors,
      nixpkgs-unfree,
      ...
    }@inputs:
    let
      inherit (self) outputs lib;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ];
      overlays = [
        (import ./overlay/default.nix)
        agenix.overlays.default
        (final: prev: {
          wlroots_0_19 = prev.wlroots_0_19.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [
              (prev.fetchpatch {
                url = "https://gitlab.freedesktop.org/wlroots/wlroots/uploads/bd115aa120d20f2c99084951589abf9c/DisplayLink_v2.patch";
                hash = "sha256-vWQc2e8a5/YZaaHe+BxfAR/Ni8HOs2sPJ8Nt9pfxqiE=";
              })
            ];
          });
        })
      ];
      nixosModules = import ./modules;
      legacyPackages = forAllSystems (
        system:
        import inputs.nixpkgs {
          inherit system overlays;
        }
      );
    in
    {
      inherit legacyPackages nixosModules;
      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixfmt-rfc-style);

      nixosConfigurations =
        let
          defaultModules = (builtins.attrValues nixosModules) ++ [
            agenix.nixosModules.default
            home-manager.nixosModules.default
          ];
          serverModules = [
            agenix.nixosModules.default
          ];
          specialArgs = {
            inherit
              inputs
              outputs
              overlays
              nix-colors
              nixpkgs-unfree
              ;
          };
        in
        {
          hiten = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = defaultModules ++ [
              ./machines/hiten/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.hagoromo = import ./machines/hiten/home.nix;
              }
            ];
          };
          hakuto = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = defaultModules ++ [
              ./machines/hakuto/configuration.nix
              nixos-hardware.nixosModules.framework-13-7040-amd
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.hagoromo = import ./machines/hakuto/home.nix;
                home-manager.extraSpecialArgs = { inherit nixpkgs-unfree; };
              }
            ];
          };
          kaguya = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = serverModules ++ [
              ./machines/kaguya/configuration.nix
              ./machines/kaguya/hardware-configuration.nix
            ];
          };
        };
    };
}
