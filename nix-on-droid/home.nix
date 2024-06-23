{ config, lib, pkgs, inputs, rootPath, ... }:
{
  home.stateVersion = "23.11";
  imports = [ ./neovim.nix ];

}
