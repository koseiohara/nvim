

return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require('toggleterm').setup({
                persist_size = false,
                start_in_insert = false,
                size = function(term)
                    if term.direction == 'horizontal' then
                        return 10
                    elseif term.direction == 'vertical' then
                        return math.min(70, math.floor(vim.o.columns * 0.45))
                    end
                    return 15
                end,
            })
            local terminal = require('toggleterm.terminal').Terminal

            local Vterm = terminal:new({
                direction = 'vertical',
            })

            local Hterm = terminal:new({
                direction = 'horizontal',
            })

            local Tterm = terminal:new({
                direction = 'tab',
            })

            vim.api.nvim_create_user_command('Vterm', function()
                Vterm:toggle()
            end,{})

            vim.api.nvim_create_user_command('Hterm', function()
                Hterm:toggle()
            end,{})

            vim.api.nvim_create_user_command('Tterm', function()
                Tterm:toggle()
            end,{})

            vim.keymap.set('n', '<leader>tt', '<cmd>Tterm<CR>', {silent = true})
            vim.keymap.set('n', '<leader>vt', '<cmd>Vterm<CR>', {silent = true})
            vim.keymap.set('n', '<leader>ht', '<cmd>Hterm<CR>', {silent = true})

            vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]], { silent = true })
            vim.keymap.set('t', 'kj'   , [[<C-\><C-n>]], { silent = true })
            vim.keymap.set('t', 'Kj'   , [[<C-\><C-n>]], { silent = true })
            vim.keymap.set('t', 'KJ'   , [[<C-\><C-n>]], { silent = true })
        end,
    },
}

