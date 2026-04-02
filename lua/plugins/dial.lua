

return {
    'monaqa/dial.nvim',
    event  = 'VeryLazy',
    config = function()
        local augend = require('dial.augend')
        local config = require('dial.config')
        local map    = require('dial.map')

        config.augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.constant.alias.bool,
                augend.constant.new({
                    elements = { 'begin', 'end' },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '<=', '>=' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '<', '>' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '+', '-' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { 'in', 'out', 'inout' },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { 'in', 'Out', 'Inout' },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { 'IN', 'OUT', 'INOUT' },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '.true.', '.false.' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '.True.', '.False.' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '.TRUE.', '.FALSE.' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = {
                        'jan',
                        'feb',
                        'mar',
                        'apr',
                        'may',
                        'jun',
                        'jul',
                        'aug',
                        'sep',
                        'oct',
                        'nov',
                        'dec',
                    },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = {
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec',
                    },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = {
                        'JAN',
                        'FEB',
                        'MAR',
                        'APR',
                        'MAY',
                        'JUN',
                        'JUL',
                        'AUG',
                        'SEP',
                        'OCT',
                        'NOV',
                        'DEC',
                    },
                    word   = true,
                    cyclic = true,
                }),
            },

            visual = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.constant.alias.bool,
                augend.constant.new({
                    elements = { 'begin', 'end' },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '<=', '>=' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '<', '>' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '+', '-' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { 'in', 'out', 'inout' },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { 'in', 'Out', 'Inout' },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { 'IN', 'OUT', 'INOUT' },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '.true.', '.false.' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '.True.', '.False.' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { '.TRUE.', '.FALSE.' },
                    word   = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = {
                        'jan',
                        'feb',
                        'mar',
                        'apr',
                        'may',
                        'jun',
                        'jul',
                        'aug',
                        'sep',
                        'oct',
                        'nov',
                        'dec',
                    },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = {
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec',
                    },
                    word   = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = {
                        'JAN',
                        'FEB',
                        'MAR',
                        'APR',
                        'MAY',
                        'JUN',
                        'JUL',
                        'AUG',
                        'SEP',
                        'OCT',
                        'NOV',
                        'DEC',
                    },
                    word   = true,
                    cyclic = true,
                }),
            },
        })

        vim.keymap.set('n', '<C-a>', function()
            map.manipulate('increment', 'normal', 'default')
        end, { desc = 'dial increment' })

        vim.keymap.set('n', '<C-x>', function()
            map.manipulate('decrement', 'normal', 'default')
        end, { desc = 'dial decrement' })

        vim.keymap.set('x', '<C-a>', function()
            map.manipulate('increment', 'visual', 'visual')
        end, { desc = 'dial increment visual' })

        vim.keymap.set('x', '<C-x>', function()
            map.manipulate('decrement', 'visual', 'visual')
        end, { desc = 'dial decrement visual' })

        -- vim.keymap.set('n', 'g<C-a>', function()
        --     map.manipulate('increment', 'gnormal', 'with_date')
        -- end, { desc = 'dial increment' })

        -- vim.keymap.set('n', 'g<C-x>', function()
        --     map.manipulate('decrement', 'gnormal', 'with_date')
        -- end, { desc = 'dial decrement' })

        -- vim.keymap.set('x', 'g<C-a>', function()
        --     map.manipulate('increment', 'gvisual', 'with_date')
        -- end, { desc = 'dial increment visual' })

        -- vim.keymap.set('x', 'g<C-x>', function()
        --     map.manipulate('decrement', 'gvisual', 'with_date')
        -- end, { desc = 'dial decrement visual' })
    end,

}



