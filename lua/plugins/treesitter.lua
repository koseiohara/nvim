

return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function()
        if vim.fn.executable('tree-sitter') == 1 then
            vim.cmd('TSUpdate')
        end
    end,
    config = function()
        require('nvim-treesitter').setup({
            install_dir = vim.fn.stdpath('data') .. '/site',
            highlight = {
                enable = true,
                -- disable = {
                --     'fortran',
                -- },
            },
            indent = {
                enable = true,
                -- disable = {
                --     'fortran',
                -- },
            },
        })

        if vim.fn.executable('tree-sitter') == 1 then
            require('nvim-treesitter').install({
                'python',
                'fortran',
                'lua',
                'vim',
                'c',
                'bash',
                'markdown',
                'markdown_inline',
                'latex',
            })
        end

        -- vim.api.nvim_create_autocmd('FileType', {
        --     group = vim.api.nvim_create_augroup('treesitter-auto-start', { clear = true }),
        --     pattern = {'*'},
        --     callback = function(ev)
        --         if vim.g.bigfile_mode then
        --             return
        --         end
        --         pcall(vim.treesitter.start, ev.buf)
        --     end,
        -- })
    end,
}



