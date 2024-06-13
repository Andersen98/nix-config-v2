{
  pkgs,
  outputs,
  inputs,
  ...
}:

{
  imports = [ <nixpkgs/nixos/modules/profiles/base.nix> ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

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
