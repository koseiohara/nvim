

return {
    'lewis6991/gitsigns.nvim',
    cond = function()
        return not vim.g.bigfile_mode
    end,
}
