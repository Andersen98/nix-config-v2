{config, nixpkgs, pkgs,...}:
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
}
