{config, pkgs, lib, inputs, outputs,...}:

{
  imports = [ ./defaultShell ];

  hannah.system.defaultShell.enable = lib.mkDefault "bash";
}
