

return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    -----@type oil.SetupOpts
    opts = {},
    -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    dependencies = { "nvim-mini/mini.icons" },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
        vim.api.nvim_set_hl(0, 'OilBackColor', {
            ctermbg = 234,
            ctermfg = 250,
        })
        vim.api.nvim_set_hl(0, 'OilCursorLine', {
            ctermbg = 237,
            ctermfg = 255,
        })
        vim.opt.splitright = true
        local oil = require('oil')


        -- Automatically Open Oil --
        oil.setup({
            view_options = {
                show_hidden = true,
            },

            keymaps = {
                ['<C-h>'] = false,
                ['<C-l>'] = false,
                ['<CR>'] = {
                    callback = function()
                        local entry = oil.get_cursor_entry()
                        if not entry then
                            return
                        end

                        if entry.type == 'directory' then
                            oil.select()
                            return
                        end

                        local dir = oil.get_current_dir()
                        if not dir then
                            return
                        end

                        local path   = vim.fs.joinpath(dir, entry.name)
                        local curwin = vim.api.nvim_get_current_win()

                        vim.cmd('wincmd l')
                        local rightwin = vim.api.nvim_get_current_win()

                        if (rightwin == curwin) then
                            -- vim.cmd('close')
                            vim.cmd('edit ' .. vim.fn.fnameescape(path))
                            vim.cmd('vert leftabove Oil')
                            vim.cmd('wincmd H')
                            vim.cmd('vertical resize 30')
                            vim.cmd('wincmd l')
                        else
                            vim.cmd('edit ' .. vim.fn.fnameescape(path))
                        end
                            -- oil.select({ vertical = true, split = "belowright" })
                    end,
                    desc = 'Open file on the right, but cd into directory in Oil',
                }
            },
            win_options = {
                wrap = false,
                signcolumn = 'no',
                cursorcolumn = false,
                foldcolumn = '0',
            },
        })

        local function open_oil_left(dir)
            local oil = require('oil')
            dir = dir or vim.fn.getcwd()

            vim.cmd('topleft vsplit')
            vim.cmd('vertical resize 30')

            oil.open(dir, nil, function()
                vim.cmd('wincmd H')
                vim.cmd('vertical resize 30')
                vim.opt_local.number = false
                vim.opt_relativenumber = false
                vim.cmd('setlocal winfixwidth')
            end)

            vim.cmd('wincmd l')
        end

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'oil',
            callback = function()
                vim.cmd('setlocal winfixwidth')
                vim.cmd('vertical resize 30')
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false

                vim.opt_local.winhighlight = 'Normal:OilBackColor,' .. 
                                             'CursorLine:OilCursorLine,'
            end,
        })

        vim.keymap.set('n', '<Leader>e', function()
            open_oil_left(vim.fn.getcwd())
        end,
        {
            desc = 'Open Oil on the left'
        })

        vim.api.nvim_create_autocmd('VimEnter', {
            callback = function()
                vim.schedule(function()
                    open_oil_left(vim.fn.getcwd())
                end)
            end,
        })
    end,
}



