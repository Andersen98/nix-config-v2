{config, ...}:
{
  programs.kitty = {
    enable = true;
    font.name = "SauceCodePro Nerd Font"; # "Hack Nerd Font";
    font.size = 16;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      foreground = "#${config.colorScheme.palette.base05}";
      background = "#${config.colorScheme.palette.base00}";
      selection_foreground = "#${config.colorScheme.palette.base05}";
      selection_background = "#${config.colorScheme.palette.base02}";
    };
  };
}
