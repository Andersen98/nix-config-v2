-- extra config
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

--vim.opt.formatoptions =  't,c,r,o,/,q,l,1,],j,a'
-- vim.opt.textwidth = 52
vim.opt.wrap = false
vim.opt.listchars:append({ space = '_', tab = '>~', trail = '-', nbsp = '+', precedes = '<', extends = '>'})
vim.opt.sidescroll = 5

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
vim.opt.infercase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.whichwrap = "b,s"

vim.opt.mouse = ""
-- terminal exit
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true,})

vim.opt.shada = "!,'100,<100,s1000,h,%100"

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2
-- vim.opt.autochdir = true;
