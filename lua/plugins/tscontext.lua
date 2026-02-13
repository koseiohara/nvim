

return {
    'nvim-treesitter/nvim-treesitter-context',
    event = { "BufNewFile", "BufReadPre" },
    config = function()
        require('treesitter-context').setup({
            enable = true,
            multiwindow = false,
            max_lines = 0,
            line_numbers = true,
            multiline_threshold = 10,
            trim_scope = 'outer',
            mode = 'cursor',
            -- separator = '_'
        })
    end,
}
