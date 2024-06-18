{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
      # oh-my-fish plugins are stored in their own repositories, which
      # makes them simple to import into home-manager.
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }
    ];
    shellAbbrs = {
      nrs = "nixos-rebuild switch";
    };
    shellAliases = {
      g = "git";
      "..." = "cd ../../";
    };
    functions = {
      fish_user_key_bindings = {
        body = ''
          bind \cl forward-char
          bind \ch backward-char
          bind \cj down-or-search
          bind \ck up-or-search
          bind \cw forward-word
          bind \cb backward-word
        '';
      };
      develope = {
        wraps = "nix develop";
        body = "env ANY_NIX_SHELL_PKGS=(basename (pwd))\"#\"(git describe --tags --dirty) (type -P nix) develop --command fish";
        description = "Wrap nix develop to run with fish";
      };
      "todays-playground" = {
        description = "Make a playground directory and cd to it";
        body = ''
          set -f today (date +%B-%d-%Y | tr '[:upper:]' '[:lower:]')
          if test -d ~/playground/$today
              cd ~/playground/$today
          else
              mkdir -p ~/playground/$today
              cd  ~/playground/$today
          end
        '';
      };
    };
  };
}
