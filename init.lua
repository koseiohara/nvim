


-- set color scheme --
vim.cmd('syntax on')
vim.cmd('colorscheme sorbet')

-- set leader key --
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

require('config.is_big_file')
require('config.keymap')
require('config.viewoption')
require('config.lazy')
require('config.replace')
require('config.winbar')
vim.opt_local.winbar = "%{%v:lua.FileLocationWinBar()%}"


-- never use mouse --
vim.opt.mouse = ''


-- auto indent --
vim.opt.smartindent = true
vim.opt.autoindent  = true

-- display line number --
vim.opt.number         = true
vim.opt.relativenumber = true
-- vim.opt.numberwidth    = 5

-- can open 50 files --
vim.opt.tabpagemax  = 50
vim.opt.showtabline = 2

-- show 2 at least lines under and above cursor line --
vim.opt.scrolloff  = 2

-- automatically reflects updates of the opened file --
vim.opt.autoread = true

-- max number of character to unlimited --
vim.opt.textwidth = 0


vim.opt.foldmethod     = 'indent'
vim.opt.foldcolumn     = '0'
vim.opt.foldlevelstart = 99

-- vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
--     pattern = 'Makefile',
--     callback = function()
--         vim.opt_local.expandtab = false
--     end,
-- })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.nml',
    callback = function()
        vim.bo.filetype = 'fortran'
    end,
})

