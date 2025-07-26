local o = vim.o
local fn = vim.fn

o.number = true
o.relativenumber = true
o.mouse = 'a'

o.undofile = true
o.undodir = fn.stdpath('config') .. '/undo'
fn.mkdir(o.undodir, 'p')

o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.cursorline = true

o.clipboard = 'unnamedplus'

vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

vim.api.nvim_set_hl(0, "LineNr", { fg = "#5c5c5c", bg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e0af68", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
