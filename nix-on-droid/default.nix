{ config, lib, pkgs, homeManagerLoadout, rootPath, inputs, ...}:

{
  environment.packages = with pkgs; [
    # utils
    fasd # command line prodcivity booster
    gh # github command line utility
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    just # A a command runner

    git
    procps
    killall
    diffutils
    findutils
    fd
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ];
  environment.etcBackupExtension = ".bak";
  system.stateVersion = "23.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  time.timeZone = "America/New_York";
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit rootPath;
      inherit homeManagerLoadout;
    };
    config = ./home.nix;
    backupFileExtension = "hm-back";
    useGlobalPkgs = true;
  };
}
