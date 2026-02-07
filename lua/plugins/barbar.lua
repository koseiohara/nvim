

return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- -- animation = true,
        -- -- insert_at_start = true,
        -- -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released

    cond = function()
        return not vim.g.bigfile_mode
    end,

    config = function()
        vim.api.nvim_set_hl(0, 'BufferCurrent'    , {cterm={bold=true}, bold=true, ctermbg=153, bg='#aec7ff', ctermfg=16 , fg='#000000'})
        vim.api.nvim_set_hl(0, 'BufferCurrentMod' , {                              ctermbg=153, bg='#aec7ff', ctermfg=21 , fg='#0000ff'})
        vim.api.nvim_set_hl(0, 'BufferVisible'    , {                              ctermbg=235, bg='#262626', ctermfg=153, fg='#aec7ff'})
        vim.api.nvim_set_hl(0, 'BufferAlternate'  , {                              ctermbg=235, bg='#262626', ctermfg=153, fg='#aec7ff'})
        vim.api.nvim_set_hl(0, 'BufferInactive'   , {                              ctermbg=235, bg='#262626', ctermfg=153, fg='#aec7ff'})
        vim.api.nvim_set_hl(0, 'BufferSeparator'  , {                              ctermbg=51 , bg='#00ffff', ctermfg=51 , fg='#00ffff'})
        vim.api.nvim_set_hl(0, 'BufferTabPageFill', {                              ctermbg=240, bg='#585858', ctermfg=255, fg='#ffffff'})
        vim.api.nvim_set_hl(0, 'BufferTabpages'   , {                              ctermbg=234, bg='#1c1c1c', ctermfg=222, fg='#ffcc90'})
        vim.api.nvim_set_hl(0, 'BufferTabpagesSep', {                              ctermbg=234, bg='#1c1c1c', ctermfg=222, fg='#ffcc90'})
        vim.api.nvim_set_hl(0, 'BufferOffset'     , {                              ctermbg=234, bg='#585858', ctermfg=222, fg='#585858'})

        vim.api.nvim_set_hl(0, 'BufferCurrentSign', {                              bg = '#aec7ff', fg = '#008BC2'})

        vim.api.nvim_set_hl(0, 'BufferCurrentSignRight', { link = 'BufferCurrentSign' })
        vim.api.nvim_set_hl(0, 'BufferInactiveSign'    , { link = 'BufferInactive'    })

        require'barbar'.setup{
            animation = true,
            auto_hide = 10,

            focus_on_close = 'left',

            minimum_padding = 2,
            maximum_padding = 5,

            hide = { extensions = true, inactive = false },
            -- gitsigns = {added = {enabled = true},},
            sidebar_filetypes = {NvimTree = false,},
            icons = {
                buffer_index  = false,
                buffer_number = false,
                button = ' ',
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = {enabled = false},
                    [vim.diagnostic.severity.WARN] = {enabled = false},
                    [vim.diagnostic.severity.INFO] = {enabled = false},
                    [vim.diagnostic.severity.HINT] = {enabled = false},
                },
                filetype = {
                    custom_colors = false,
                    enabled = true,
                },
                separator = {left='▎', right=''},
                inactive = {button = 'x'},
            }
        }
    end,
}


