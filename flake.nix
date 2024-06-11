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
      #nix-community cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #  cuda-maintainers's cache server public key
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };
  outputs = {self, nixpkgs, nixos-hardware,home-manager,...}@inputs:
  let
    inherit (self) outputs;

    inherit (nixpkgs) lib;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = lib.genAttrs systems;
    allMachines = [ "lenovo-x270" "x570" "all-hardware" ];
    allLoadouts = [ "sway" "plasma5" "plasma6" ];
    allCombinations = lib.attrsets.cartesianProductOfSets { machine = allMachines; loadout = allLoadouts; };
    system = "x86_64-linux";
    genConfiguration =  { loadout, machine}:
    {
      
      inherit system;
      "${machine}-${loadout}" = lib.nixosSystem {
        modules = [ 
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
            nixpkgs.overlays = [ inputs.neorg-overlay.overlays.default ];
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hannah = ./home;
          }
          (./nixos + "/${loadout}.nix")
          (./machines + "/${machine}")
        ];
        specialArgs = {
          hostname = "${machine}-${loadout}";
            inherit
              machine
              loadout
              nixos-hardware
              home-manager
              inputs
              ;
            outputs = self.outputs;
        };
      };
    };
  in
  {
    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
     # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = lib.attrsets.mergeAttrsList (map genConfiguration allCombinations);
  };
}
