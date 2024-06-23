{
  description = "Hannah's NixOS config";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    # override the default substituters
    extra-substituters = [
      # nix community's cache server
      "https://nix-community.cachix.org"

      # nix community's cache server for cuda
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      # nix-community cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #  cuda-maintainers's cache server public key
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nix-on-droid = {
      url = "github:t184256/nix-on-droid/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
   # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixfmt.url = "github:NixOS/nixfmt";
    nix-colors.url = "github:misterio77/nix-colors";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      flake-utils,
      nix-on-droid,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      allMachines = [
        {
          hostname = "lenovo-x270";
          system = "x86_64-linux";
        }
        {
          hostname = "x570";
          system = "x86_64-linux";
        }
      ];
      allLoadouts = [
        "sway"
        "plasma5"
        "plasma6"
      ];
      allCombinations = lib.attrsets.cartesianProductOfSets {
        machine = allMachines;
        loadout = allLoadouts;
      };
      genConfiguration =
        { loadout, machine }:
        {
          "${machine.hostname}-${loadout}" = lib.nixosSystem {
            inherit (machine) system;
            modules = [
              {
                imports = [ <nixpkgs/nixos/modules/profiles/base.nix> ];
                nixpkgs = {
                  # You can add overlays here
                  overlays = [
                    (final: prev: { nvimoriginal = prev.neovim.overrideAtrrs { pname = "nvimoriginal"; }; })

                    # Add overlays your own flake exports (from overlays and pkgs dir):
                    outputs.overlays.additions
                    outputs.overlays.modifications
                    outputs.overlays.unstable-packages
                    # You can also add overlays exported from other flakes:
                    # neovim-nightly-overlay.overlays.default
                    inputs.neorg-overlay.overlays.default
                    inputs.neovim-nightly-overlay.overlays.default

                    # Or define it inline, for example:
                    # (final: prev: {
                    #   hi = final.hello.overrideAttrs (oldAttrs: {
                    #     patches = [ ./change-hello-to-hi.patch ];
                    #   });
                    # })
                  ];
                  # Configure your nixpkgs instance
                  config = {
                    # Disable if you don't want unfree packages
                    allowUnfree = true;
                  };
                };
              }
              {
                # given the users in this list the right to specify additional substituters via:
                #    1. `nixConfig.substituters` in `flake.nix`
                nix.settings.trusted-users = [ "hannah" ];

                nix.settings = {
                  substituters = [

                    "https://cache.nixos.org"
                  ];

                  trusted-public-keys = [
                    # the default public key of cache.nixos.org, it's built-in, no need to add it here
                    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  ];
                };
              }
              # make home-manager as a module of nixos
              # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
              home-manager.nixosModules.home-manager
              {

                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  inherit outputs;
                  inherit loadout;
                  inherit machine;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.hannah = ./home;
              }
              (./nixos + "/${loadout}.nix")
              (./hosts + "/${machine.hostname}")
            ];
            specialArgs = {
              inherit
                machine
                nixos-hardware
                home-manager
                inputs
                ;
              outputs = self.outputs;
            };
          };
        };
    in
    flake-utils.lib.eachDefaultSystem (system: {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = import ./pkgs nixpkgs.legacyPackages.${system};
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
      #formatter =  inputs.nixfmt.packages.${system}; # nixpkgs.legacyPackages.${system}.alejandra);
    })
    // {
      nixosConfigurations = lib.attrsets.mergeAttrsList (map genConfiguration allCombinations);
      homeManagerModules = [ (import ./home) ];

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [ ./nix-on-droid ];
        extraSpecialArgs = {
	  inherit inputs;
	  rootPath = ./.;
	};
        # Apply nix-on-droid overlay to nixpkgs
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [
            nix-on-droid.overlays.default
	    inputs.neorg-overlay.overlays.default
	    inputs.neovim-nightly-overlay.overlays.default
	  ];
        };

        home-manager-path = home-manager.outPath;
      };

    };

}
