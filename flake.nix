{
  description = "Hannah's NixOS config";
  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {self, nixpkgs, nixos-hardware,home-manager,...}@inputs:
  let
    inherit (nixpkgs) lib;
    genConfiguration =  { loadout, machine, homeModule ? ./home}:
    {
      system = "x86_64-linux";
      "${machine}-${loadout}" = lib.nixosSystem {
        modules = [
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hannah = homeModule;
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
    nixosConfigurations = genConfiguration { machine = "lenovo-x270"; loadout = "plasma5-standard";}
      // genConfiguration { machine = "lenovo-x270"; loadout = "plasma6-standard";}
      // genConfiguration {
        machine = "lenovo-x270"; 
        loadout = "sway-standard";
        homeModule = ./home/with-sway.nix;
      };
  };
}
