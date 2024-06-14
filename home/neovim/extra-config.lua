-- extra config
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false
vim.opt.sidescroll = 5
vim.opt.listchars = "tab:> ,trail:-,nbsp:+,precedes:<,extends:>"

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.cmd([[
  filetype plugin on
  filetype indent on
]])

vim.opt.clipboard = "unnamedplus"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "
