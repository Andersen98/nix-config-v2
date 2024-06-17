{ pkgs, lib, inputs, ... }:
let
  fromGitHub =
    {
      rev,
      ref,
      repo,
    }:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };
in
{
  imports = [
    ./plugins/telescope.nix
    ./plugins/noice.nix
    ./plugins/lspconfig.nix
    ./plugins/which-key.nix
  ];
  
  programs.neovim =  {
    viAlias = true;
    vimAlias = true;
    enable = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      gcc
      gnutar
      curl
    ];
    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      {
        config = ''
          require("kanagawa").load("wave")
        '';
        plugin = kanagawa-nvim;
        type = "lua";
      }
      neorg-telescope
      {
        plugin = neorg;
        config = ''
          require("neorg").setup {
             load = {
               ["core.defaults"] = {}
             }
           }
        '';
        type = "lua";
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = ''
          require("nvim-treesitter.configs").setup {
            highlight = {
              enable = true,
            }
          }
        '';
        type = "lua";
      }
      {
        plugin = (
          fromGitHub {
            repo = "nix-community/tree-sitter-nix";
            rev = "b3cda619248e7dd0f216088bd152f59ce0bbe488";
            ref = "master";
          }
        );
      }
      zen-mode-nvim
      {
        plugin = neo-tree-nvim;
        config = ''
          vim.api.nvim_set_keymap('n', '<Leader>t', '<cmd>Neotree toggle<cr>', {desc = "Tree Toggle",})
        '';
        type = "lua";
      }
      {
        plugin = vimtex;
        config = builtins.readFile ./vimtex.vim;
      }
      {
        plugin = vim-startify;
        config = "let g:startify_change_to_vcs_root = 0";
      }
    ];
  };
}
