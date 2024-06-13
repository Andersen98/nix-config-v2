{ config, pkgs,lib, outputs, inputs, ... }:
with lib;

let
  cfg = config.hannah.system.defaultShell;
in
{
  options.hannah.system.defaultShell.enable = mkOption {
    type = with types; nullOr (enum [ "fish" ]);
  };

  config = {
    
    programs = mkIf (cfg.enable == "fish") {

      fish.enable = true;
      bash = {
        interactiveShellInit = ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
        '';
      };
    };
  };
}
