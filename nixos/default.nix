{ outputs,options, pkgs, nixpkgs,lib, modulesPath, configFile, ... }:
{
  imports = [ 
    ./hosts/lenovo-x270
    ./hosts/x570
    ./desktops/sway.nix
    ./components/fhs.nix
    ./components/vscode.nix
    ./components/mk-fish-default.nix
    ./components/kbd.nix
  ];

  options = with lib; {
    host.enable = mkOption {
      description = "The host that this config will build for.";
      type = with types; nullOr (enum [ ]);
    };
    desktop.enable = mkOption {
      description = "The desktop/GUI configuration to use";
      type = with types; nullOr (enum [ ]);
    };
  };

  config = {
    #warnings = [ (builtins.trace modulesPath) "${modulesPath}/profiles/base.nix" ];
    users.groups.hannah = { };
    users.users = {
      hannah = {
        isNormalUser = true; 
        description = "Hannah Maeve Andersen";
        extraGroups = [
          "wheel"
          "video" # the below i got off github/akirak/homelab/blob/master/machines/li/default.nix#L85
          "audio"
          "disk"
          "networkmanager"
          "systemd-journal"
        ];
        shell = pkgs.fish;

      };
    };
    # given the users in this list the right to specify additional substituters via:
    #    1. `nixConfig.substituters` in `flake.nix`
    nix.settings.trusted-users = [ "hannah" ];
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    nixpkgs.overlays = outputs.overlays;
    #nix.registry.nixpkgs.flake = nixpkgs;
    #nix.channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.
    # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
    # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
    #environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
    # https://github.com/NixOS/nix/issues/9574
   # nix.settings.nix-path = lib.mkForce  options.nix.nixPath.default ++ [ 
    #  "nixpkgs-overlays=/etc/nixos/overlays-compat/"
    #  "nixpkgs=/etc/nix/inputs/nixpkgs"
    #];

  };
}

