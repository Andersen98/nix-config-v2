{config, ...}:

{
# The actual sway config
  wayland.windowManager.sway = {
    enable = true;
    extraConfig = builtins.readFile ./extra-config;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
    };
  };
}


