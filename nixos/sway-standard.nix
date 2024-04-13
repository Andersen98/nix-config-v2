{config, nixpkgs, pkgs, lib,...}:
with lib;
{
  imports = [
      ./components/sway.nix
      ./components/hannah.nix
      ./components/core-pkgs.nix
      ./components/fhs.nix
      ./components/vscode.nix
      ./components/mk-fish-default.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  security.polkit.enable = true;

  # My desktop environment does not have a bluetooth gui
  # so enable a gui here if we are using bluetooth
  services.blueman.enable =  mkIf config.hardware.bluetooth.enable true;
}
