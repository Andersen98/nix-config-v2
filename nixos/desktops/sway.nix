{
  config,
  nixpkgs,
  pkgs,
  lib,
  ...
}:
let cfg = config.desktop; in
{
  options.desktop.enable = with lib; mkOption {
    type = with types; nullOr (enum [ "sway" ]);
  };
  config = lib.mkIf (cfg.enable == "sway") {

    programs.nm-applet.enable = true;
    security.polkit.enable = true;

    # My desktop environment does not have a bluetooth gui
    # so enable a gui here if we are using bluetooth
    services.blueman.enable = lib.mkIf config.hardware.bluetooth.enable true;


    environment.systemPackages = with pkgs; [
      wofi
      networkmanagerapplet
      bluez
      networkmanager_dmenu
      pinentry-qt
      grim # screenshot functionality
      slurp # screenshot functionality
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      mako # notification system developed by swaywm maintainer
    ];

    # Enable the gnome-keyring secrets vault. 
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome.gnome-keyring.enable = true;

    # enable sway window manager
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    ########## OPTIONAL #############

    # kanshi systemd service
    systemd.user.services.kanshi = {
      description = "kanshi daemon";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
      };
    };

    # Control Brightness
    programs.light.enable = true;

    # Realtime Performance
    security.pam.loginLimits = [
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];
  };
}
