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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-on-droid = {
      url = "github:t184256/nix-on-droid/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixfmt.url = "github:NixOS/nixfmt";
    nix-colors.url = "github:misterio77/nix-colors";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      flake-utils,
      nix-on-droid,
      plasma-manager,
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
	{
	  hostname = "pink-pc";
	  system = "x86_64-linux";
	}
      ];
      allDesktops = [
        "sway"
        "plasma5"
        "plasma6"
        "other"
      ];
      allHomeManagerLoadouts = [
        "a"
	"b"
	"c"
	"d"
        "e"
      ];
      allCombinations = lib.attrsets.cartesianProduct {
        machine = allMachines;
	homeManagerLoadout = allHomeManagerLoadouts;
	desktop = allDesktops;
      };
      genNixOnDroidConfiguration = {homeManagerLoadout, ...}: 
	{ "${homeManagerLoadout}" = nix-on-droid.lib.nixOnDroidConfiguration {
	  modules = [( ./nix-on-droid) ];
	  extraSpecialArgs = {
	    inherit inputs homeManagerLoadout;
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
      genNixosConfiguration =
        { desktop, homeManagerLoadout, machine }:
        {
          "${machine.hostname}-${desktop}-${homeManagerLoadout}" = lib.nixosSystem {
            inherit (machine) system;
            modules = [
              (./nixos + "/${desktop}.nix")
              (./hosts + "/${machine.hostname}")
              ./nixos/components/plymouth.nix
              {
                imports = [ <nixpkgs/nixos/modules/profiles/base.nix> ];
                nixpkgs = {
                  # You can add overlays here
                  overlays = [
                    (final: prev: { nvimoriginal = prev.neovim.overrideAtrrs { pname = "nvimoriginal"; }; })

                    # Add overlays your own flake exports (from overlays and pkgs dir):
                    outputs.overlays.additions
                    outputs.overlays.modifications
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
                nix.settings.trusted-users = [ "hannah" "hannaha" ];

                nix.settings = {
                  substituters = [

                    "https://cache.nixos.org"
		    "https://nix-community.cachix.org"
                    "https://vulkan-haskell.cachix.org"
                  ];

                  trusted-public-keys = [
                    # the default public key of cache.nixos.org, it's built-in, no need to add it here
                    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
		    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                    "vulkan-haskell.cachix.org-1:byNXKoGxhPa/IOR+pwNhV2nHV67ML8sXsWPfRIqzNUU="
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
                  inherit machine;
                };
                home-manager.backupFileExtension = "hm-bak";
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

                home-manager.users.hannah = (./. + "/home/${homeManagerLoadout}.nix");
              }
            ];
            specialArgs = {
              inherit
                machine
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
      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = lib.attrsets.mergeAttrsList (map genNixosConfiguration allCombinations);
      nixOnDroidConfigurations = lib.attrsets.mergeAttrsList (map genNixOnDroidConfiguration allCombinations);
    };

}
