{ self, nixpkgs, ... }:
{
  imports = [
    ./components/plasma5.nix
    ./components/fhs.nix
    ./components/vscode.nix
    ./components/mk-fish-default.nix
    ./components/steam.nix
    ./components/kbd.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
