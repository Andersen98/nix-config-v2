{inputs, rootPath, pkgs, ...}:{

  imports = [ 
    (rootPath + "/home/neovim/plugins/lspconfig.nix")
    (rootPath + "/home/neovim/plugins/which-key.nix")
    (rootPath + "/home/neovim/plugins/telescope.nix")
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = builtins.readFile (rootPath + "/home/neovim/extra-config.lua");
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      { plugin = kanagawa-nvim; 
        config = ''
        require("kanagawa").load("wave")
        '';
        type = "lua";
      }
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
    ];

  };
}
