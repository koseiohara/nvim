

return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    -----@type oil.SetupOpts
    opts = {},
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
        vim.opt.splitright = true
        local oil = require('oil')
        oil.setup({
            keymaps = {
                ["<CR>"] = {
                    callback = function()
                        local entry = oil.get_cursor_entry()
                        if not entry then
                            return
                        end

                        if entry.type == "directory" then
                            oil.select()
                        else
                            oil.select({ vertical = true, split = "belowright" })
                        end
                    end,
                    desc = "Open file on the right, but cd into directory in Oil",
                }
            },
            win_options = {
                wrap = false,
                signcolumn = 'no',
                cursorcolumn = false,
                foldcolumn = '0',
            },
        })

        vim.keymap.set('n', '<Leader>e', function()
            vim.cmd('vert leftabove Oil')
        end,
        {
            desc = 'Open Oil on the left'
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'oil',
            callback = function()
                vim.cmd('setlocal winfixwidth')
                vim.cmd('vertical resize 30')
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
            end,
        })
    end,
}



