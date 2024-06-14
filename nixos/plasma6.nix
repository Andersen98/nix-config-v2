{ self, nixpkgs, ... }:
{
  imports = [
    ./components/plasma6.nix
    ./components/hannah.nix
    ./components/fhs.nix
    ./components/vscode.nix
    ./components/mk-fish-default.nix
    ./components/kbd.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
