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
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixfmt.url = "github:NixOS/nixfmt";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      flake-utils,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      configurations = [ 
        {
          configFile = ./configurations/lenovo-x270-sway.nix;
          name = "lenovo-x270-sway";
          system = "x86_64-linux";
        }
      ];
      genConfiguration =
        { configFile, name, system }:
        let pkgs = import nixpkgs { inherit  system; overlays = outputs.overlays ; };
        in
        {
          ${name} = lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit nixpkgs inputs outputs configFile;
            };
            modules = [
              (configFile)
              (./nixos/default.nix)
              # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.hannah = ./home;
              }
            ];
          };
        };
    in
    flake-utils.lib.eachDefaultSystem (system: {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = import ./pkgs {pkgs= nixpkgs.legacyPackages.${system}; inherit inputs;};
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
      #formatter =  inputs.nixfmt.packages.${system}; # nixpkgs.legacyPackages.${system}.alejandra);
    })
    // {
      nixosConfigurations = lib.attrsets.mergeAttrsList (map genConfiguration configurations);
      homeManagerModules = [ (import ./home) ];

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
    };
}
