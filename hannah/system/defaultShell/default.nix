{config, lib, inputs, outputs, ...}:
with lib;

let
  cfg = config.hannah.systemShell;
in
{
  imports = [ ./fish.nix ./bash.nix ./zsh.nix ];

  # Using and extensible option we make a placeholder
  # value in the current central module (here)
  # and then we extend it in each backend module
  options.hannah.systemShell = mkOption {
    description =''
      The shell that the system uses. Inherits values from
      the login shell. Setting this to a non POSIX shell
      can cause weird behaviour (eg. fish).
    '';
    type = with types; nullOr (enum [ ]);
  };

}
  
