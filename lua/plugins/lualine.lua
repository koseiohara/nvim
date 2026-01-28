
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'tomorrow_night',
                    globalstatusline = false,
                    icons_enabled = true,
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {
			    'branch',
			    'diagnostics',
		    },
                    lualine_c = {
                        {
                            'hostname',
                        },
                        {
                            'filename',
                            path = 1,
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

