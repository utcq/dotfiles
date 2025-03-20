require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
o.cursorline = true
o.number = true
o.relativenumber = true

vim.g.vimtex_mainfile_detection = 1
vim.g.vimtex_view_method = 'zathura'  -- Use Zathura as PDF viewer
vim.g.vimtex_quickfix_mode = 0        -- Disable quickfix window
vim.g.vimtex_compiler_method = 'latexmk'  -- Use latexmk for compilation
vim.g.vimtex_compiler_latexmk = {
    options = {'-pdf', '-interaction=nonstopmode', '-synctex=1'}
}

local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
})
