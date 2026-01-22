
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'powerline_dark',
                    icons_enabled = false,
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '|', right = '|' },
                    always_showtabline = true,
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
                    },
                    lualine_x = {
                        {
                            'encoding',
                        },
                        {
                            'fileformat',
                        },
                        {
                            'filetype',
                        },
                    },
                },
                tablines = {
                    lialine_a = {'tabs'},
                    --lualine_b = {'branch'},
                },
            }
        end,
    },
}

