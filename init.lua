
-- set color scheme --
vim.cmd('syntax on')
vim.cmd('colorscheme sorbet')

-- set leader key --
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('config.lazy')

-- never use mouse --
vim.opt.mouse = ''

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



-- set tab width to 4 --
vim.opt.tabstop     = 4
-- auto indent width to 4 --
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = 0

-- auto indent --
vim.opt.smartindent = true
vim.opt.autoindent  = true
-- Tab to spaces --
vim.opt.expandtab   = true

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

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = 'Makefile',
    callback = function()
        vim.opt_local.expandtab = false
    end,
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.nml',
    callback = function()
        vim.bo.filetype = 'fortran'
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

-- macro for key mapping --
local map = vim.keymap.set
local nore          = {noremap = true}
local nore_silent   = {noremap = true, silent = true}
local nore_nosilent = {noremap = true, silent = false}
-- Basic Cursor Movement --
map({'n', 'v', 'o'}, 'gh', '^'  , nore)
map({'n', 'v', 'o'}, 'gl', '$'  , nore)
map({'n', 'v', 'o'}, 'gk', 'gg' , nore)
map({'n', 'v', 'o'}, 'gj', 'G'  , nore)
map({'n', 'v', 'o'}, '<S-h>', '10h', nore)
map({'n', 'v', 'o'}, '<S-l>', '10l', nore)
map({'n', 'v', 'o'}, '<S-k>', '10k', nore)
map({'n', 'v', 'o'}, '<S-j>', '10j', nore)

map('n', '<Leader>b', '%'    , nore_silent)
map('n', 'x'        , '"_x'  , nore_silent)
map('n', 's'        , '"_s'  , nore_silent)
map('n', ';'        , ':'    , nore_silent)
map('n', '<Leader>q', 'q:'   , nore_silent)
map('n', 'q:'       , '<Nop>', nore_silent)
map('n', '<Leader>n', ':set relativenumber!<CR>', nore_silent)

-- set tab --
map('n', '<Tab>'        , ':tabnext<CR>'    , nore_silent)
map('n', '<S-Tab>'      , ':tabprevious<CR>', nore_silent)
map('n', '<Leader>topen', ':tabnew '        , nore_nosilent)

-- move window --
-- map('n', '<C-l>', ':wincmd l<CR>', nore_silent)
-- map('n', '<C-h>', ':wincmd h<CR>', nore_silent)
-- map('n', '<C-k>', ':wincmd k<CR>', nore_silent)
-- map('n', '<C-j>', ':wincmd j<CR>', nore_silent)
map('n', '<C-l>', '<C-w>l', nore_silent)
map('n', '<C-h>', '<C-w>h', nore_silent)
map('n', '<C-k>', '<C-w>k', nore_silent)
map('n', '<C-j>', '<C-w>j', nore_silent)

-- set window --
map('n', '<Leader>vs'   , ':vsplit<CR>', nore_silent  )
map('n', '<Leader>hs'   , ':split<CR>' , nore_silent  )
map('n', '<Leader>vopen', ':vsplit '   , nore_nosilent)
map('n', '<Leader>hopen', ':split '    , nore_nosilent)
map('n', '<Leader><BS>' , ':close<CR>' , nore_silent  )
map('n', '<Leader>h'    , '<C-w><<CR>' , nore_silent  )
map('n', '<Leader>l'    , '<C-w>><CR>' , nore_silent  )
map('n', '<Leader>k'    , '<C-w>+<CR>' , nore_silent  )
map('n', '<Leader>j'    , '<C-w>-<CR>' , nore_silent  )
map('n', '<Leader>eq'   , '<C-w>=<CR>' , nore_silent  )

-- return to normal mode --
map('i', 'kj', '<Esc>', nore)
map('i', 'Kj', '<Esc>', nore)
map('i', 'KJ', '<Esc>', nore)

-- indent modification file visual mode --
map('v', '<', '<gv', nore)
map('v', '>', '>gv', nore)

vim.opt_local.winbar = "%{%v:lua.FileLocationWinBar()%}"

local function replace_selected()
    local old = vim.fn.getreg('/') or ''

    if old:sub(1, 2) == '\\<' and old:sub(-2) == '\\>' then
        old = old:sub(3, -3)
    end

    old = vim.fn.escape(old, '/')

    local prompt = ('replace %s to '):format(old)
    local new    = vim.fn.input(prompt)

    if new == nil or new == '' then
        vim.api.nvim_echo({ { "=> Warning : Specify a new word! rpl command was canceled", "WarningMsg" } }, false, {})
        return
    end

    new = vim.fn.escape(new, '/')
    vim.cmd(("%s/\\V%s/%s/g"):format("%", old, new))
end
vim.api.nvim_create_user_command('Rpl', replace_selected, {})
vim.cmd('cabbrev rpl Rpl')


_G.FileLocationWinBar = function()
    if vim.bo.filetype == 'oil' then
        return ''
    end

    if vim.bo.buftype ~= '' then
        return ''
    end

    local dir = vim.fn.expand('%:p:h')
    if not dir or dir == '' then
        return ''
    end

    di = dir:gsub('/$', '')

    if dir == '' then
        dir = '/'
    end

    local parts = vim.split(dir, '/', { plain = true, trimempty = true })

    local crumbs = {}
    if dir:sub(1, 1) == '/' then
        if #parts >= 1 then
            table.insert(crumbs, '/' .. parts[1])
            for i = 2, #parts do
                table.insert(crumbs, parts[i])
            end
        else
            table.insert(crumbs, '/')
        end
    else
        for i = 1, #parts do
            table.insert(crumbs, parts[i])
        end
    end

    local out = {'    '}
    for i, c in ipairs(crumbs) do
        table.insert(out, '%#MainWinbarCrumb#')
        table.insert(out, c)
        if i <= #crumbs then
            table.insert(out, '%#MainWinbarSep#')
            table.insert(out, ' > ')
        end
    end
    table.insert(out, '%#MainWinbarCrumb#')
    table.insert(out, vim.fn.expand('%:t'))

    return table.concat(out)
end



