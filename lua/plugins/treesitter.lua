

return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = function()
        if vim.fn.executable('tree-sitter') == 1 then
            vim.cmd(':TSUpdate')
        end
    end,
    config = function()
        require('nvim-treesitter').setup({
            install_dir = vim.fn.stdpath('data') .. '/site',
        })

        local lang = {
            'python',
            'fortran',
            'lua',
            'vim',
            'c',
            'bash',
            'markdown',
            'markdown_inline',
            'latex',
        }

        if vim.fn.executable('tree-sitter') == 1 then
            require('nvim-treesitter').install(lang)
        end

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter-auto-start', { clear = true }),
            pattern = lang,
            callback = function(ev)
                if vim.g.bigfile_mode then
                    return
                end
                if ev.match == 'fortran' then
                    return
                end

                pcall(vim.treesitter.start, ev.buf)
                vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}



