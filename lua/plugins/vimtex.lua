-- Settings in Skim:
-- Sync:
--     Command: nvim
--     Argument: --headless -c 'VimtexInverseSearch %line '%file''

return {
    'lervag/vimtex',
    lazy = false,
    init = function()
        -- if vim.fn.has('macunix') ~= 1 then
        --     return
        -- end
        -- vim.g.vimtex_view_method     = 'skim'

        if vim.fn.has('macunix') == 1 then
            vim.g.vimtex_view_method = 'skim'
        elseif vim.fn.has('win32') == 1 then
            vim.g.vimtex_view_method = 'sumatrapdf'
        elseif vim.fn.has('unix') == 1 then
            vim.g.vimtex_view_method = 'zathura'
        end

        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.vimtex_quickfix_mode   = 2
        vim.g.vimtex_quickfix_open_on_warning = 0

        vim.g.vimtex_compiler_latexmk = {
            options = {
                '-pdfdvi',
            },
        }

        vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
            pattern = '*.cls',
            callback = function()
                vim.bo.filetype = 'tex'
            end,
        })

        local TEMPLATE = vim.fn.expand('~/.config/nvim/tools/.latexmkrc')
        local RC_NAME = '.latexmkrc'

        local function stat(path)
            return vim.uv.fs_stat(path) ~= nil
        end

        local function vimtex_main_root(buf)
            local b = vim.b[buf]
            if type(b) ~= 'table' then
                return nil, nil
            end
            local v = b.vimtex
            if type(v) ~= 'table' then
                return nil, nil
            end
            local root = v.root
            local main = v.tex
            if type(root) ~= 'string' or root == '' then
                return nil, nil
            end
            if type(main) ~= 'string' or main == '' then
                return nil, nil
            end
            if not stat(main) then
                return nil, nil
            end
            return main, root
        end


        local function ensure_rc_for_current_buf()
            local buf = vim.api.nvim_get_current_buf()
            local main, root = vimtex_main_root(buf)
            if not main or not root then
                return
            end

            if not stat(TEMPLATE) then
                return
            end

            local dst = root .. '/' .. RC_NAME
            if stat(dst) then
                return
            end

            local fd_in = vim.uv.fs_open(TEMPLATE, 'r', 0)
            if not fd_in then
                return
            end
            local data = vim.uv.fs_read(fd_in, 1024 * 1024, 0)
            vim.uv.fs_close(fd_in)
            if not data then
                return
            end

            -- vim.fn.input(
            --     string.format(
            --         'NOTICE: %s was copied to %s',
            --         TEMPLATE,
            --         dst
            --     )
            -- )

            local fd_out = vim.uv.fs_open(dst, 'wx', 420)
            if not fd_out then
                return
            end
            vim.uv.fs_write(fd_out, data, 0)
            vim.uv.fs_close(fd_out)
        end


        local function compile()
            ensure_rc_for_current_buf()

            if vim.fn.exists(':VimtexCompileSS') == 2 then
                vim.cmd('VimtexCompileSS')
            elseif vim.fn.exists(':VimtexCompile') == 2 then
                vim.cmd('VimtexCompile')
            end
        end

        local group = vim.api.nvim_create_augroup('tex_file', { clear = true })


        -- Override <localleader>ll to copy .latexmkrc
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'tex',
            callback = function(args)
                -- vimtex が有効なときだけ上書き
                if vim.b[args.buf].vimtex then
                    vim.keymap.set(
                        'n',
                        '<localleader>ll',
                        function()
                            compile()
                        end,
                        {
                            buffer = args.buf,
                            silent = true,
                            desc = 'VimTeX (wrapped): compile with rc-copy check',
                        }
                    )
                end
            end,
        })

        -- Check whether vim is being closed
        local vimtex_exiting = false
        vim.api.nvim_create_autocmd({'VimLeavePre' }, {
            group = group,
            callback = function()
                vimtex_exiting = true
            end,
        })

        -- auto compiler (only if vim is not being closed)
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            group = group,
            pattern = { '*.tex', '*.cls' },
            callback = function()
                if vimtex_exiting then
                    return
                end
                vim.schedule(function()
                    compile()
                end)
            end,
        })

        -- Error Message Window
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = { 'tex', 'plaintex' },
            callback = function(args)
                vim.keymap.set('n', '<localleader>le', function()
                    -- Close if quickfix is open
                    for _, win in ipairs(vim.fn.getwininfo()) do
                        if win.quickfix == 1 then
                            vim.cmd('cclose')
                            return
                        end
                    end
                    -- Open quickfix
                    vim.cmd('VimtexErrors')
                end, { buffer = false, silent = true, desc = 'Toggle VimTeX errors' })
            end,
        })

    end,
}



