-- extra config
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.textwidth = 52
vim.opt.wrap = false
vim.opt.listchars = { space = '_', tab = '>~', trail = '-', nbsp = '+', precedes = '<', extends = '>'}
vim.opt.sidescroll = 8

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.cmd([[
  filetype plugin on
  filetype indent on
]])

vim.opt.clipboard = ""

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.opt.whichwrap = "b,s"
