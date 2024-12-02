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
        '';
        type = "lua";
      }
    ];
  };
}
