
return {
    {
        'shellRaining/hlchunk.nvim',
        cond = function()
            return not vim.g.bigfile_mode
        end,

        config = function()
            require('hlchunk').setup({
                chunk = {
                    enable = true,
                    chars = {
                        horizontal_line = '─',
                        vertical_line = '│',
                        left_top = '╭',
                        left_bottom = '╰',
                        right_arrow = '>',
                    },
                },
                indent = {
                    enable = true,
                    chars = {
                        '│',
                        '|',
                    },
                    style = {
                        '#2b2b35',
                    },
                },
            })
        end
    },
}


