{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ......omit many configurations

  environment.systemPackages = with pkgs; [
    # ......omit many packages

    # Create an FHS environment using the command `cuda-fhs`, enabling the execution of non-NixOS packages in NixOS!
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSUserEnv (
        base
        // {
          name = "cuda-fhs";
          targetPkgs =
            pkgs:
            (
              # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
              # lacking many basic packages needed by most software.
              # Therefore, we need to add them manually.
              #
              # pkgs.appimageTools provides basic packages required by most software.
              (base.targetPkgs pkgs)
              ++ (with pkgs; [
                pkg-config
                git
                gitRepo
                gnupg
                autoconf
                curl
                procps
                gnumake
                util-linux
                m4
                gperf
                unzip
                cudatoolkit
                linuxPackages.nvidia_x11
                libGLU
                libGL
                xorg.libXi
                xorg.libXmu
                freeglut
                xorg.libXext
                xorg.libX11
                xorg.libXv
                xorg.libXrandr
                zlib
                ncurses5
                stdenv.cc
                binutils
                # Feel free to add more packages here if needed.
              ])
            );
          multiPkgs = pkgs: with pkgs; [ zlib ];
          profile = ''
            export CUDA_PATH=${pkgs.cudatoolkit}
            # export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib
            export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
            export EXTRA_CCFLAGS="-I/usr/include"
            export FHS=1
          '';
          runScript = "bash";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];

  # ......omit many configurations
}
