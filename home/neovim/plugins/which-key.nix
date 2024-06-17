{pkgs,...}:{
  programs.neovim = {

    plugins = with pkgs.vimPlugins; [

      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          local wk = require('which-key')
          wk.register({
            ["<leader>"] = {

            },
            ["<leader>"] = {
              h = {
                name = "+help",
                t = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
              },
            },
            ["<leader>"] = {
              f = {
                name = "+file",
                f = { "<cmd>Telescope find_files<cr>", "Find File" },
                g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
                r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
                n = { "<cmd>enew<cr>", "New File" },
              },
              b = {
                name = "+buffer",
                p = { "<cmd>Telescope buffers<cr>", "Pick Buffer" },
              },
              h = {
                name = "+help",
                t = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
              },
            },
          })
        '';
      }
    ];

  };
}
