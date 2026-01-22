return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'ayu_dark',
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch'},
                    lualine_c = {
                        {
                            'hostname',
                        },
                        {
                            'filename',
                            path = 2,
                        },
                    }
                }
            }
        end,
    },
}

