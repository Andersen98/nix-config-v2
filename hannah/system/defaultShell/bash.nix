{config, lib,...}:
with lib;
{
  options.hannah.system.defaultShell.enable = mkOption {
    type = with types; nullOr (enum [ "bash" ]);
  };

  config = {
    programs.bash.enable = true;
  };
}
