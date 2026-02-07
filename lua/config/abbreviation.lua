

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'fortran'},
    callback = function()
        vim.cmd('iabbrev <buffer> ;;r real') 
        vim.cmd('iabbrev <buffer> ;;i integer') 
        vim.cmd('iabbrev <buffer> ;;l logical') 
        vim.cmd('iabbrev <buffer> ;;c character') 
    end,
})



