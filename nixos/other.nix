{

  imports = [
    ./components/hannah.nix
    ./components/fhs.nix
    ./components/mk-fish-default.nix
    ./components/kbd.nix
    ./components/pipewire-graphical.nix
    ./components/pipewire.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
