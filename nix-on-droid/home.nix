{ config, lib, pkgs, inputs, homeManagerLoadout, rootPath, ... }:
{
  home.stateVersion = lib.mkForce "23.11";
  home.username = lib.mkForce "nix-on-droid";
  home.homeDirectory = lib.mkForce "/data/data/com.termux.nix/files/home";
  imports = [
    (rootPath + "/home/${homeManagerLoadout}.nix")

    {
      home.file.".config/nix/nix.conf".text = ''
        extra-trusted-users = nix-on-droid
        extra-substituters = https://nix-community.cachix.org
        extra-trusted-public-keys = nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
      '';
    }
  ];


}
