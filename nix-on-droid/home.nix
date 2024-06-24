{ config, lib, pkgs, inputs, homeManagerLoadout, rootPath, ... }:
{
  home.stateVersion = lib.mkForce "23.11";
  home.username = lib.mkForce "nix-on-droid";
  home.homeDirectory = lib.mkForce "/data/data/com.termux.nix/files/home";
  imports = [ (rootPath + "/home/${homeManagerLoadout}.nix")];

}
