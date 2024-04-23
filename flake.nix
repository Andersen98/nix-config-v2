{
  description = "Hannah's NixOS config";

    # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    # override the default substituters
    substituters = [

      "https://cache.nixos.org"

      # nix community's cache server
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      #  cuda-maintainers's cache server public key
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {self, nixpkgs, nixos-hardware,home-manager,...}@inputs:
  let
    inherit (nixpkgs) lib;
    allMachines = [ "lenovo-x270" "x570" ];
    allLoadouts = [ "sway-standard" "plasma5-standard" "plasma6-standard" ];
    allCombinations = lib.attrsets.cartesianProductOfSets { machine = allMachines; loadout = allLoadouts; };

    genConfiguration =  { loadout, machine}:
    {
      system = "x86_64-linux";
      "${machine}-${loadout}" = lib.nixosSystem {
        modules = [
          {
            # given the users in this list the right to specify additional substituters via:
            #    1. `nixConfig.substituters` in `flake.nix`
            nix.settings.trusted-users = [ "root" "hannah" ];
          }
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { };
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
              nixos-hardware
              home-manager;
        };
      };
    };
  in
  {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map genConfiguration allCombinations);
  };
}
