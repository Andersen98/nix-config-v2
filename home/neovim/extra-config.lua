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

vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
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
-- Move window in any mode
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true,})
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', {noremap = true,})
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', {noremap = true,})
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', {noremap = true,})
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', {noremap = true,})
vim.api.nvim_set_keymap('n', '<A-w>', '<C-w>w', {noremap = true,})
vim.api.nvim_set_keymap('t' ,'<A-h>' ,'<C-\\><C-N><C-w>h', {noremap = true,})
vim.api.nvim_set_keymap('t' ,'<A-j>' ,'<C-\\><C-N><C-w>j', {noremap = true,})
vim.api.nvim_set_keymap('t' ,'<A-k>' ,'<C-\\><C-N><C-w>k', {noremap = true,})
vim.api.nvim_set_keymap('t' ,'<A-l>' ,'<C-\\><C-N><C-w>l', {noremap = true,})
vim.api.nvim_set_keymap('t' ,'<A-w>' ,'<C-\\><C-N><C-w>w', {noremap = true,})
vim.api.nvim_set_keymap('i' ,'<A-h>' ,'<C-\\><C-N><C-w>h', {noremap = true,})
vim.api.nvim_set_keymap('i' ,'<A-j>' ,'<C-\\><C-N><C-w>j', {noremap = true,})
vim.api.nvim_set_keymap('i' ,'<A-k>' ,'<C-\\><C-N><C-w>k', {noremap = true,})
vim.api.nvim_set_keymap('i' ,'<A-l>' ,'<C-\\><C-N><C-w>l', {noremap = true,})
vim.api.nvim_set_keymap('i' ,'<A-w>' ,'<C-\\><C-N><C-w>w', {noremap = true,})

vim.opt.shada = "!,'100,<100,s1000,h,%100"

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2
-- vim.opt.autochdir = true;
