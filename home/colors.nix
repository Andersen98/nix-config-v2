{inputs,...}:
{
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  colorscheme = inputs.nix-colors.colorSchemes.pandora;
}
