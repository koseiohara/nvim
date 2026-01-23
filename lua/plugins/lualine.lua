
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'powerline',
                    globalstatusline = false,
                    icons_enabled = false,
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '|', right = '|' },
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
            }
        end,
    },
}

