local group = vim.api.nvim_create_augroup('NeoVimRc', { clear = true })
local M = {}

M.dot = function(callback)
    return function()
        _G.dot_repeat_callback = callback
        vim.go.operatorfunc = 'v:lua.dot_repeat_callback'
        vim.cmd('normal! g@l')
    end
end

M.au = function(event, opts)
    opts['group'] = group
    return vim.api.nvim_create_autocmd(event, opts)
end

return M
