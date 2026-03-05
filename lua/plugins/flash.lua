

return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},

    config = {
        vim.api.nvim_set_hl(0, 'FlashLabel', {
            fg = '#dddddd',
            bg = '#881313',
        })
    },

    keys = {
        {
            'gs',
            mode = {'n', 'x', 'o'},
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
        {
            'gS',
            mode = {'n', 'x', 'o'},
            function()
                require('flash').treesitter()
            end,
            desc = 'Flash Treesitter',
        },
        {
            'r',
            mode = {'o'},
            function()
                require('flash').remote()
            end,
            desc = 'Remote Flash',
        },
        {
            'R',
            mode = {'o', 'x'},
            function()
                require('flash').treesitter_search()
            end,
            desc = 'Treesitter Search',
        },
        {
            '<C-s>',
            mode = {'c'},
            function()
                require('flash').toggle()
            end,
            desc = 'Toggle Flash Search',
        },
    },
}



