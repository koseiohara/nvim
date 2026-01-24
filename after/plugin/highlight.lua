

vim.opt.cursorcolumn = true
local clgrp = vim.api.nvim_create_augroup(
    'CursorLineMode',
    {clear = true}
)

vim.api.nvim_create_autocmd('VimEnter', {
    group = clgrp,
    pattern = '*',
    callback = function()
        vim.api.nvim_set_hl(0, 'CursorLine', {
            -- cterm = {},
            ctermbg = 238,
            bg='#444444',
        })
        vim.opt.cursorline = true
    end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
    group = clgrp,
    pattern = '*',
    callback = function()
        vim.opt.cursorline = true
        vim.api.nvim_set_hl(0, 'CursorLine', {
            -- cterm = {underline = true},
            underline = true,
            ctermbg = 238,
            bg='#444444',
        })
    end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
    group = clgrp,
    pattern = '*',
    callback = function()
        vim.opt.cursorline = true
        vim.api.nvim_set_hl(0, 'CursorLine', {
            ctermbg = 238,
            bg='#444444',
        })
    end,
})

vim.api.nvim_set_hl(0, 'CursorColumn'   , {cterm={}              ,                 ctermbg=238, bg='#444444'})
vim.api.nvim_set_hl(0, 'Constant'       , {cterm={}              ,                                            ctermfg=10 , fg='#00ff00'})
vim.api.nvim_set_hl(0, 'Comment'        , {cterm={}              ,                                            ctermfg=245, fg='#8a8a8a'})
vim.api.nvim_set_hl(0, 'Folded'         , {cterm={}              ,                 ctermbg=18 , bg='#000087', ctermfg=202, fg='#ff5f00'})
vim.api.nvim_set_hl(0, 'Search'         , {cterm={bold=true}     , bold=true,      ctermbg=237, bg='#3a3a3a', ctermfg=226, fg='#ffff00'})
vim.api.nvim_set_hl(0, 'LineNr'         , {cterm={}              ,                 ctermbg=235, bg='#262626', ctermfg=247, fg='#9e9e9e'})
vim.api.nvim_set_hl(0, 'CursorLineNr'   , {cterm={}              ,                 ctermbg=16 , bg='#000000', ctermfg=202, fg='#ff5f00'})
vim.api.nvim_set_hl(0, 'FoldColumn'     , {cterm={}              ,                 ctermbg=0  , bg='#000000', ctermfg=9  , fg='#ff0000'})
vim.api.nvim_set_hl(0, 'TabLine'        , {cterm={}              ,                 ctermbg=237, bg='#3a3a3a', ctermfg=255, fg='#eeeeee'})
vim.api.nvim_set_hl(0, 'TabLineSel'     , {cterm={bold=true}     , bold=true,      ctermbg=242, bg='#6c6c6c', ctermfg=255, fg='#eeeeee'})
vim.api.nvim_set_hl(0, 'TabLineFill'    , {cterm={}              ,                 ctermbg=232, bg='#080808', ctermfg=232, fg='#080808'})
vim.api.nvim_set_hl(0, 'VertSplit'      , {cterm={}              ,                 ctermbg=233, bg='#121212', ctermfg=233, fg='#121212'})

vim.api.nvim_set_hl(0, 'MainWinbarCrumb', {cterm={underline=true}, underline=true, ctermbg=233, bg='#121212', ctermfg=153, fg='#afd7ff'})
vim.api.nvim_set_hl(0, 'MainWinbarSep'  , {cterm={underline=true}, underline=true, ctermbg=233, bg='#121212', ctermfg=153, fg='#afd7ff'})



