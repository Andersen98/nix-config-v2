-- extra config
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.cmd([[
  filetype plugin on
  filetype indent on
]])

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  }
}

require("neorg").setup {
  load = {
    ["core.defaults"] = {}
  }
}
