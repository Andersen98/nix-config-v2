{ 
  pkgs,
  ...
}:
{
  imports = [
    ./minimal.nix
    ./texlive.nix
    ./kitty.nix
    ./starship-pastel-preset.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # devenv https://devenv.sh
    devenv

    neofetch

    #fonts
    nerdfonts

    # internet
    firefox
    discord
    lynx

    # media
    obs-studio
    vlc
    inkscape
    blender

    # xorg
    xclip
  ];
}

