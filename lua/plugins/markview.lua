

return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    ft = {'markdown'},

    config = function()
        local markview = require('markview.commands')

        require('markview').setup({
            preview = {
                enable = false,
            }
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'markdown',
            callback = function(event)
                vim.keymap.set('n', '<leader>md', function()
                    markview.Toggle()
                end, {
                    buffer = event.buf,
                    desc   = 'Markview: Toggle Split View',
                    silent = true,
                })
            end,
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'markdown',
            callback = function(event)
                vim.keymap.set('n', '<leader>ms', function()
                    markview.splitToggle()
                end, {
                    buffer = event.buf,
                    desc   = 'Markview: Toggle Split View',
                    silent = true,
                })
            end,
        })
    end,
}


