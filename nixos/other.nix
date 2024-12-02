{

  imports = [
    ./components/hannah.nix
    ./components/fhs.nix
    ./components/mk-fish-default.nix
    ./components/kbd.nix
    ./components/pipewire-graphical.nix
    ./components/pipewire.nix
  ];

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.wayland.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
