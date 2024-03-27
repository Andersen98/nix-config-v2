{config, nixpkgs, pkgs,...}:
{
  imports = [
      ./components/core-pkgs.nix
      ./components/fhs.nix
      ./components/vscode.nix
      ./components/mk-fish-default.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };
  
  # Realtime to improve latency
  # the "users" group get's realtime priority.
  security.pam.loginLimits = [
    { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  ];

  # You have to enable polkit!
  security.polkit.enable = true;

  # Adjust Brightness
  programs.light.enable = true;

  users.groups.hannah = {};


}
