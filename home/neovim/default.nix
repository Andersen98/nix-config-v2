{pkgs, ...}:
{
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    plugins = with pkgs.vimPlugins; [
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

