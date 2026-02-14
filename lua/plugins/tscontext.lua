

return {
    'nvim-treesitter/nvim-treesitter-context',
    event = { "BufNewFile", "BufReadPre" },
    config = function()
        require('treesitter-context').setup({
            enable = true,
            multiwindow = false,
            max_lines = 5,
            line_numbers = true,
            multiline_threshold = 10,
            trim_scope = 'inner',
            mode = 'cursor',
            -- separator = '_'
        })
        vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {
            sp = '#7aa2f7',
            underline = true
        })
    end,
}


