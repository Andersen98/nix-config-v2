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
#    ./plugins/noice.nix
    ./plugins/lspconfig.nix
    ./plugins/which-key.nix
    ./plugins/base16-nvim.nix
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
      neorg-telescope
      {
        plugin = neorg;
        config = ''
          require("neorg").setup {
             load = {
               ["core.defaults"] = {},
               ["core.concealer"] = {},
               ["core.dirman"] = {
                  config = {
                    workspaces = {
                      wiki = "~/neorg/wiki",
                      playground = "~/neorg/playground",
                    },
                    default_workspace = "playground",
                  },
                }
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
