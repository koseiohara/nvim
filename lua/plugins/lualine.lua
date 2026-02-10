
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        -- cond = function()
        --     return not vim.g.bigfile_mode
        -- end,

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
                        {
                            'diagnostics',
                            source = {
                                'nvim_diagnostic'
                            },
                            sections = {
                                'error',
                                'warn',
                            },
                        },
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
                            cond = function()
                                return not vim.g.bigfile_mode
                            end,
                            function()
                                local wc    = vim.fn.wordcount()
                                local chars = tostring(math.max((wc.chars or 0) - 1, 0)) .. 'c'
                                local words = tostring(wc.words or 0) .. 'w'
                                local lines = tostring(vim.fn.line('$') or 0) .. 'l'
                                local out   =  chars .. ', ' .. words ..', ' .. lines
                                return out
                            end,
                        }
                    }
                },
            }
        end,
    },
}

