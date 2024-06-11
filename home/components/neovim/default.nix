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
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    extraPackages = with pkgs; [ cargo gcc git curl ];
    extraLuaPackages = luaPkgs: with luaPkgs; [ luarocks rocks-nvim ];
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = neorg;
        config = ''
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
          }
        }
        '';
        type = "lua";      
      }
      neorg-telescope
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
    ];
  };
}

