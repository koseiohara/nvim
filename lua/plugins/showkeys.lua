

return {
    'nvzone/showkeys',
    opts = {

        vim.api.nvim_set_hl(0, 'ShowkeysNormal', {
            bg = '#202045',
            fg = '#dddddd',
        }),

        vim.api.nvim_set_hl(0, 'ShowkeysBorder', {
            bg = '#202045',
            fg = '#dddddd',
        }),

        timeout = 10,
        maxkeys = 6,
        position = 'bottom-right',

        winhl = 'FloatBorder:ShowkeysBorder,Normal:ShowkeysNormal',

        keyformat = {
            ['<BS>']    = 'BS',
            ['<CR>']    = 'Return',
            ['<Up>']    = 'Up',
            ['<Down>']  = 'Down',
            ['<Left>']  = 'Left',
            ['<Right>'] = 'Right',
        },
        vim.cmd('cabbrev sk ShowkeysToggle')
    }
}



