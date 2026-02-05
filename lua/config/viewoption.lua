
-- remember fold and position of cursor --
vim.opt.viewoptions = {'folds', 'cursor'}
local remember = vim.api.nvim_create_augroup('RememberFolds', {clear = true})
vim.api.nvim_create_autocmd('BufWinLeave', {
    group = remember,
    pattern = '*',
    callback = function()
        pcall(vim.cmd, 'silent! mkview')
    end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
    group = remember,
    pattern = '*',
    callback = function()
        pcall(vim.cmd, 'silent! loadview')
    end,
})


local start_at_first_line = vim.api.nvim_create_augroup("start_at_first_line", { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group    = start_at_first_line,
    pattern  = 'gitcommit'        ,
    callback = function()
        vim.opt_local.viewoptions = ''
        vim.cmd('normal! gg')
    end,
})

