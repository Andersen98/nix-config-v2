{ config, lib, ... }:

{
  options.hannah.nixos.loadout = lib.mkOption {
    type = lib.types.enum [
      "sway"
      "plasma5"
      "plasma6"
    ];
    description = "What loadout do you want to use for the nixOS configuration?";
    default = "plasma5";
  };
}
