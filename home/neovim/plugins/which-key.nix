{pkgs,...}:{
  programs.neovim = {

    plugins = with pkgs.vimPlugins; [
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          local wk = require('which-key')
          wk.add({
            { "<leader>b", group = "buffer" },
            { "<leader>bp", "<cmd>Telescope buffers<cr>", desc = "Pick Buffer" },
            { "<leader>f", group = "file" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
            { "<leader>h", group = "help" },
            { "<leader>ht", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
            { "<leader>l", group = "language server" },
            { "<leader>lD", function() vim.lsp.buf.declaration() end, desc = "go to declaration" },
            { "<leader>ld", function() vim.lsp.buf.definition() end, desc = "go to definition" },
            { "<leader>ls", function() vim.lsp.buf.signature_help() end, desc = "signature help" },
            { "<leader>lr", function() vim.lsp.buf.rename() end, desc = "rename" },
            { "<leader>la", function() vim.lsp.buf.code_action() end, desc = "code action" },
            { "<leader>d", group = "diagnostics" },
            { "<leader>dn", function() vim.diagnostic.goto_prev() end, desc = "go to previous" },
            { "<leader>dN", function() vim.diagnostic.goto_next() end, desc = "go to next" },
            { "<leader>do", function() vim.diagnostic.vim.diagnostic.open_float() end, desc = "open float" },
            { "<leader>dl", function() vim.diagnostic.vim.diagnostic.setloclist() end, desc = "set loc list" },
          })
        '';
      }
    ];

  };
}
