

local grp = vim.api.nvim_create_augroup('ForceIndent', { clear = true })

vim.api.nvim_create_autocmd({'FileType', 'BufEnter'}, {
    group   = grp,
    pattern = '*',
    callback = function()
        -- set tab width to 4 --
        vim.opt_local.tabstop     = 4
        -- auto indent width to 4 --
        vim.opt_local.shiftwidth  = 4
        vim.opt_local.softtabstop = 0
        if vim.bo.filetype == 'make' then
            -- Tab not to spaces --
            vim.opt_local.expandtab   = false
        else
            -- Tab to spaces --
            vim.opt_local.expandtab   = true
        end
    end,
})

