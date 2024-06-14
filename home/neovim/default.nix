{
  pkgs,
  lib,
  ...
}:
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

  programs.neovim = rec {
    viAlias = true;
    vimAlias = true;
    enable = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    extraPackages = with pkgs; [ gcc gnutar curl ];
    plugins = with pkgs.vimPlugins; [
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
        plugin = (fromGitHub {
          repo="nix-community/tree-sitter-nix";
          rev="b3cda619248e7dd0f216088bd152f59ce0bbe488"; 
          ref="master";
        });
      }
      zen-mode-nvim
      {
        plugin = neo-tree-nvim;
        config = ''
          vim.keymap.set('n', '<Leader>t', '<cmd>Neotree toggle<cr>')
          vim.keymap.set('n', '<Leader>b', '<cmd>Neotree toggle show buffers right<cr>')
          vim.keymap.set('n', '<Leader>s', '<cmd>Neotree float git_status<cr>')
          vim.keymap.set('n', '<cr>', '<cmd>Neotree reveal<cr>')
          vim.keymap.set('n', 'gd', '<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>')
          vim.keymap.set('n', '<leader>b', '<cmd>Neotree toggle show buffers right<cr>')
          vim.keymap.set('n', '<leader>s', '<cmd>Neotree float git_status<cr>')
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
