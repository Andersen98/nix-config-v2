{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hannah = {
    isNormalUser = true;
    group = "hannah";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "video" # the below i got off github/akirak/homelab/blob/master/machines/li/default.nix#L85
      "audio"
      "disk"
      "networkmanager"
      "systemd-journal"
    ];
  };
  users.groups.hannah = { };
}
