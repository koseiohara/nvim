
return {
    {
        'shellRaining/hlchunk.nvim',
        config = function()
            require('hlchunk').setup({
                chunk = {
                    enable = true,
                    chars = {
                        horizontal_line = "─",
                        vertical_line = "│",
                        left_top = "╭",
                        left_bottom = "╰",
                        right_arrow = ">",
                    },
                },
            })
        end
    },
}


