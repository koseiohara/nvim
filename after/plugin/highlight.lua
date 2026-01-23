

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
            cterm = {},
            ctermbg = 238,
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
            cterm = {underline = true},
            ctermbg = 238,
        })
    end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
    group = clgrp,
    pattern = '*',
    callback = function()
        vim.opt.cursorline = true
        vim.api.nvim_set_hl(0, 'CursorLine', {
            cterm = {},
            ctermbg = 238,
        })
    end,
})

vim.api.nvim_set_hl(0, 'CursorColumn', {cterm={}, ctermbg=238})
vim.api.nvim_set_hl(0, 'Constant'    , {cterm={}, ctermfg=10 })
vim.api.nvim_set_hl(0, 'Comment'     , {cterm={}, ctermfg=245})
vim.api.nvim_set_hl(0, 'Folded'      , {cterm={}, ctermbg=18 , ctermfg=202})
vim.api.nvim_set_hl(0, 'Search'      , {cterm={bold=true}, ctermbg=237, ctermfg=226})
vim.api.nvim_set_hl(0, 'LineNr'      , {cterm={}, ctermbg=235, ctermfg=247})
vim.api.nvim_set_hl(0, 'CursorLineNr', {cterm={}, ctermbg=16 , ctermfg=202})
vim.api.nvim_set_hl(0, 'FoldColumn'  , {cterm={}, ctermbg=0  , ctermfg=9  })
vim.api.nvim_set_hl(0, 'TabLine'     , {cterm={}, ctermbg=237, ctermfg=255})
vim.api.nvim_set_hl(0, 'TabLineSel'  , {cterm={bold=true}, ctermbg=242, ctermfg=255})
vim.api.nvim_set_hl(0, 'TabLineFill' , {cterm={}, ctermbg=232, ctermfg=232})
vim.api.nvim_set_hl(0, 'VertSplit'   , {cterm={}, ctermbg=233, ctermfg=233})

vim.api.nvim_set_hl(0, 'MainWinbarCrumb', {cterm={underline = true}, ctermbg=233, ctermfg=153})
vim.api.nvim_set_hl(0, 'MainWinbarSep'  , {cterm={underline = true}, ctermbg=233, ctermfg=153})



