

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
        vim.api.nvim_set_hl(0, 'NormalFloat', {
            bg = '#ffffff',
            fg = '#6a6a6a',
        })
        vim.api.nvim_set_hl(0, 'OilCreate', {
            fg = '#00008c',
        })
        vim.api.nvim_set_hl(0, 'OilBackColor', {
            ctermbg = 234,
            ctermfg = 250,
            bg = '#1c1c1c',
            fg = '#bcbcbc',
        })
        vim.api.nvim_set_hl(0, 'OilCursorLine', {
            ctermbg = 237,
            ctermfg = 255,
            bg = '#3a3a3a',
            fg = '#eeeeee',
        })
        vim.api.nvim_set_hl(0, 'OilWinColor', {
            ctermbg = 234,
            ctermfg = 250,
            bg = '#1c1c1c',
            fg = '#bcbcbc',
        })
        vim.opt.splitright = true
        local oil = require('oil')


        oil.setup({
            -- Automatically Open Oil --
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

        local function tab_has_oil(tabpage)
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].filetype == 'oil' then
                    return true, win
                end
            end
            return false, nil
        end

        local function ensure_oil_left(dir)
            dir = dir or vim.fn.getcwd()

            if vim.g._opening_oil_sidebar then 
                return
            end

            vim.g._opening_oil_sidebar = true

            local tab = vim.api.nvim_get_current_tabpage()
            local has, oilwin = tab_has_oil(tab)

            if not has then
                vim.cmd('topleft vsplit')
                vim.cmd('vertical resize 30')

                local oil = require('oil')
                oil.open(dir, nil, function()
                    vim.cmd('wincmd H')
                    vim.cmd('vertical resize 30')
                    vim.opt_local.number = false
                    vim.opt_local.relativenumber = false
                    vim.cmd('setlocal winfixwidth')
                end)

                vim.cmd('wincmd l')
            else
                vim.api.nvim_set_current_win(oilwin)
                vim.cmd('wincmd H')
                vim.cmd('vertical resize 30')
                vim.cmd('setlocal winfixwidth')
                vim.cmd('wincmd l')
            end
            vim.g._opening_oil_sidebar = false
        end


        local function open_oil_left(dir)
            local oil = require('oil')
            dir = dir or vim.fn.getcwd()

            vim.cmd('topleft vsplit')
            vim.cmd('vertical resize 40')

            oil.open(dir, nil, function()
                vim.cmd('wincmd H')
                vim.cmd('vertical resize 40')
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.cmd('setlocal winfixwidth')
            end)

            vim.cmd('wincmd l')
        end

        _G.OilWinbar = function()
            local oil = require('oil')
            local dir = oil.get_current_dir() or ''

            dir = dir:gsub('/$', '')

            local name = vim.fn.fnamemodify(dir, ':t')
            if name == '' then
                name = dir == '/' and '/' or '[NO NAME]'
            end

                return table.concat({
                    '%#OilWinColor#', 'Current >> ' .. name .. '/'
                })
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

                vim.opt_local.winbar = "%{%v:lua.OilWinbar()%}"

            end,
        })

        vim.keymap.set('n', '<Leader>e', function()
            open_oil_left(vim.fn.getcwd())
        end,
        {
            desc = 'Open Oil on the left'
        })

        -- vim.api.nvim_create_autocmd({'VimEnter', 'TabEnter', 'TabNewEntered'}, {
        --     callback = function()
        --         vim.schedule(function()
        --             local ft = vim.bo.filetype
        --             if ft == 'gitcommit' or ft == 'gitrebase' then
        --                 return
        --             end

        --             -- open_oil_left(vim.fn.getcwd())
        --             ensure_oil_left(vim.fn.getcwd())
        --         end)
        --     end,
        -- })
    end,
}



