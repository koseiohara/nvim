
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
                    lualine_y = {
                        {
                            function()
                                local wc = vim.fn.wordcount()
                                local out = tostring(math.max((vim.fn.wordcount().chars or 0) - 1, 0)) .. 'c, ' .. tostring(wc.words or 0) .. 'w'
                                return out
                            end,
                        }
                    }
                },
            }
        end,
    },
}

