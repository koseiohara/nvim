

local BIG = 50 * 1024 * 1024

vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function(args)
        local path = vim.api.nvim_buf_get_name(args.buf)
        if path == '' then
            return
        end

        local size = vim.fn.getfsize(path)

        if size < 0 or size <= BIG then
            return
        end

        vim.b[args.buf].bigfile = true

        vim.opt_local.syntax = 'off'
        vim.opt_local.foldmethod = 'manual'
        vim.opt_local.foldexpr = ''
        vim.opt_local.foldenable = false

        vim.opt_local.swapfile = false
        vim.opt_local.undofile = false

        vim.opt_local.wrap = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.conceallevel = 0
        vim.opt_local.synmaxcol = 128
    end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        if not vim.b[args.buf].bigfile then return end
        pcall(vim.treesitter.stop, args.buf)
    end,
})


