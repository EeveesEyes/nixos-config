{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-secrets = {
      url = "path:/home/hagoromo/Projects/nixos/nixos-secrets";
      # url = "git+file:///home/hagoromo/Projects/nixos/nixos-secrets?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sftp-mount.url = "github:tupakkatapa/nixos-sftp-mount";
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
      sops-nix,
      nixos-secrets,
      sftp-mount, 
      ...
    }@inputs:
    let
      overlays = [
        (import ./overlay/displaylink.nix)
      ];
      nixpkgsOverlaid = import inputs.nixpkgs { inherit overlays; };
      inherit (self) outputs lib;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ];
      nixosModules = import ./modules;
      legacyPackages = forAllSystems (
        system:
        import inputs.nixpkgs {
          inherit system;
          overlays = overlays;
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
              nix-colors
              nixpkgs-unfree
              agenix
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
              sops-nix.nixosModules.sops
              sftp-mount.nixosModules.sftpClient
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.hagoromo = import ./machines/hakuto/home.nix;
                home-manager.extraSpecialArgs = { inherit nixpkgs-unfree; };
                environment.systemPackages = [
                  agenix.packages.x86_64-linux.default
                ];
              }
              (nixos-secrets.nixosModules.sopsSecrets)
              (nixos-secrets.nixosModules.ageSecrets)
            ];
          };
        };
    };
}
