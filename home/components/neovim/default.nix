{pkgs,lib, inputs,...}:
let
  fromGitHub = {rev, ref, repo}: pkgs.vimUtils.buildVimPlugin {
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
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    plugins = with pkgs.vimPlugins; [
      zen-mode-nvim
      {
        plugin = neorg-telescope;
        config = ''
        require("nvim-treesitter.configs").setup {
                    highlight = {
                      enable = true,
                    }
                  }
        '';
        type = "lua";
      }
      nvim-treesitter.withAllGrammars
      (fromGitHub {
        repo = "nvim-neorg/lua-utils.nvim";
        rev = "e565749421f4bbb5d2e85e37c3cef9d56553d8bd";
        ref = "main";
        }
      )
      (fromGitHub {
        repo = "nvim-neotest/nvim-nio";
        rev = "33c62b3eadd8154169e42144de16ba4db6784bec";
        ref = "master";
      })
      nui-nvim
      plenary-nvim
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
      { plugin = neo-tree-nvim;
        config = ''
        vim.keymap.set('n', '<Leader>t', '<cmd>Neotree toggle<cr>')
        vim.keymap.set('n', '<Leader>b', '<cmd>Neotree toggle show buffers right<cr>')
        vim.keymap.set('n', '<Leader>s', '<cmd>Neotree float git_status<cr>')
        -- nnoremap | :Neotree reveal<cr>
        -- nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
        -- nnoremap <leader>b :Neotree toggle show buffers right<cr>
        -- nnoremap <leader>s :Neotree float git_status<cr>
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
      lualine-nvim
    ];
  };
}

