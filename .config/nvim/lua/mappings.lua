require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map('n', '<leader>ll', ':VimtexCompile<CR>', { noremap = true, silent = true })
map('n', '<leader>lv', ':VimtexView<CR>', { noremap = true, silent = true })
