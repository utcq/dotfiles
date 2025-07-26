local map = vim.keymap.set
vim.g.mapleader = " "

-- Buffers
map('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
map('n', '<Space>x', ':bd<CR>', { noremap = true, silent = true })


-- Windows
map('n', '<leader>sv', ':vsplit<CR>')
map('n', '<leader>sh', ':split<CR>')
-- Resize splits
map('n', '<C-Up>', ':resize +2<CR>')
map('n', '<C-Down>', ':resize -2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- Misc
map('n', '<leader><space>', ':noh<CR>')
map('n', '<leader>/', ':CommentToggle<CR>')
map('v', '<leader>/', ':CommentToggle<CR>')
map('n', '<Space>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
map('n', '<Space>d', ':Telescope diagnostics<CR>', { noremap = true, silent = true })
