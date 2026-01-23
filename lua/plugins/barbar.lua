

return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    pts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- -- animation = true,
        -- -- insert_at_start = true,
        -- -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released

    config = function()
        vim.api.nvim_set_hl(0, 'BufferCurrent'    , {cterm={bold}, ctermbg=152, ctermfg=16})
        vim.api.nvim_set_hl(0, 'BufferCurrentMod' , {ctermbg=152, ctermfg=21})
        vim.api.nvim_set_hl(0, 'BufferVisible'    , {ctermbg=235, ctermfg=152})
        vim.api.nvim_set_hl(0, 'BufferAlternate'  , {ctermbg=235, ctermfg=152})
        vim.api.nvim_set_hl(0, 'BufferInactive'   , {ctermbg=235, ctermfg=152})
        vim.api.nvim_set_hl(0, 'BufferTabPageFill', {ctermbg=240, ctermfg=255})
        vim.api.nvim_set_hl(0, 'BufferSeparator'  , {ctermbg=51 , ctermfg=51 })
        -- vim.api.nvim_set_hl(0, 'BufferTabpagesSep', {ctermbg=51 , ctermfg=51 })

        require'barbar'.setup{
            animation = true,
            auto_hide = 10,

            focus_on_close = 'left',

            hide = { extensions = true, inactive = false },
            -- gitsigns = {added = {enabled = true},},
            sidebar_filetypes = {NvimTree = false,},
            icons = {
                buffer_index  = false,
                buffer_number = false,
                buttom = '',
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = {enabled = false},
                    [vim.diagnostic.severity.WARN] = {enabled = false},
                    [vim.diagnostic.severity.INFO] = {enabled = false},
                    [vim.diagnostic.severity.HINT] = {enabled = false},
                },
                filetype = {
                    custom_colors = false,
                    enabled = false,
                },
                separator = {left='|', right=''},
                inactive = {button = 'x'},
            }
        }
    end,
}


