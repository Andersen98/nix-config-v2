{config, pkgs, lib, ...}:
{


  imports = [
    ./neovim
    ./bash.nix
    ./fish.nix
    ./colors.nix
  ];

  # This config was copied and modified from the following
  # nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager
  home.username = lib.mkDefault "hannah";
  home.homeDirectory = lib.mkDefault "/home/hannah";

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Example of how to link the configuration file in current directory
  # to the specified location in home directory.
  #
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # Example of how to link link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };
  home.file."config/cabal" = {
    source = ./cabal;
    recursive = true;
    executable = false;
  };

  home.file.".config/networkmanager-dmenu" = {
    source = ./networkmanager-dmenu;
    recursive = true;
    executable = false;
  };

  home.file.".config/xdg-desktop-portal" = {
    source = ./xdg-desktop-portal;
    recursive = true;
    executable = false;
  };
    
  home.file.".config/wofi" = {
    source = ./wofi;
    recursive = true;
    executable = false;
  };
  home.file.".config/sway/config".text = (import ./sway/config.nix) {inherit config; inherit lib;};
  home.file.".config/sway/config.d" = {
    source = ./sway/config.d;
    recursive = true;
    executable = false;
  };

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # devenv https://devenv.sh
    devenv
    neofetch

    # internet
    lynx

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    fasd # command line prodcivity booster
    curl
    git
    gh
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    just # A a command runner

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    fortune
    lolcat
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = lib.mkDefault "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
