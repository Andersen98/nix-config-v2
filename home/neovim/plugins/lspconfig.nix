{pkgs,...}:{

  programs.neovim = {

    extraPackages = with pkgs; [
      nil #nix lsp
      pyright
      haskell-language-server
      (haskellPackages.ghcWithPackages (pkgs: with pkgs; [ cabal-install turtle ]))
      icu
      ncurses
      zlib
    ];
    plugins = with pkgs.vimPlugins; [

      { plugin = nvim-lspconfig;
        config = ''
          require('lspconfig').nil_ls.setup{}
          require('lspconfig').pyright.setup{}
          require('lspconfig')['hls'].setup{
            filetypes = { 'haskell', 'lhaskell', 'cabal' },
          }
          local lsp_mappings = {
          { 'gD', vim.lsp.buf.declaration },
          { 'gd', vim.lsp.buf.definition },
          { 'gi', vim.lsp.buf.implementation },
          { 'gr', vim.lsp.buf.references },
          { '[d', vim.diagnostic.goto_prev },
          { ']d', vim.diagnostic.goto_next },
          { '<Leader><Leader>' , vim.lsp.buf.hover },
          { '<Leader><Leader>s', vim.lsp.buf.signature_help },
          { '<Leader><Leader>d', vim.diagnostic.open_float },
          { '<Leader><Leader>q', vim.diagnostic.setloclist },
          { '\\r', vim.lsp.buf.rename },
          { '\\a', vim.lsp.buf.code_action },
        }
        for i, map in pairs(lsp_mappings) do
          vim.keymap.set('n', map[1], function() map[2]() end)
        end
        vim.keymap.set('x', '\\a', function() vim.lsp.buf.code_action() end)
        '';
        type = "lua";
      }
    ];
  };
}
