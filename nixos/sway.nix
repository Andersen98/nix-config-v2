{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  imports = [
    ./components/sway.nix
    ./components/hannah.nix
    ./components/fhs.nix
    ./components/vscode.nix
    ./components/mk-fish-default.nix
    ./components/kbd.nix
    ./components/pipewire-graphical.nix
    ./components/pipewire.nix
  ];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
    XDG_CURRENT_DESKTOP = "sway";
  };
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    wofi
    networkmanagerapplet 
    xdg-desktop-portal-wlr
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    pavucontrol
    networkmanager_dmenu
  ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  security.polkit.enable = true;

  # My desktop environment does not have a bluetooth gui
  # so enable a gui here if we are using bluetooth
  services.blueman.enable = mkIf config.hardware.bluetooth.enable true;
}
