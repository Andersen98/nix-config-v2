{
  config,
  pkgs,
  lib,
  ...
}:

{
  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    # custom settings
    settings = {
      format = lib.concatStrings [
        "[](#9A348E)"
        "$os"
        "$username"
        "[](bg:#DA627D fg:#9A348E)"
        "$directory"
        "[](fg:#DA627D bg:#FCA17D)"
        "$git_branch"
        "$git_status"
        "[](fg:#FCA17D bg:#86BBD8)"
        "$nix_shell"
        "[](fg:#86BBD8 bg:#06969A)"
        "$time"
        "[ ](fg:#33658A)"
      ];
      username = {
        show_always = true;
        style_user = "bg:#9A348E";
        style_root = "bg:#9A348E";
        format = "[$user ]($style)";
        disabled = false;
      };
      os = {
        style = "bg:#9A348E";
        disabled = false; # Disabled by default, but i enabled it.
      };
      directory = {
        style = "bg:#DA627D";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };
      nix_shell = {
        style = "bg:#86BBD8";
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#33658A";
        format = "[ ♥ $time ]($style)";
      };
      git_branch = {
        symbol = "";
        style = "bg:#FCA17D";
        format = "[ $symbol $branch ]($style)";
      };
      git_status = {
        style = "bg:#FCA17D";
        format = "[$all_status$ahead_behind ]($style)";
      };
    };
  };
}
