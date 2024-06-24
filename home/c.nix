{ config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./minimal.nix
    ./kitty.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    #fonts
    nerdfonts

    # internet
    firefox

    # media
    vlc

    # xorg
    xclip
  ];
}

