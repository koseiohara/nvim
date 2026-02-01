

local function is_big_file(threshold)
    threshold = threshold or (50*1024*1024)
    for _, a in ipairs(vim.v.argv) do
        if a:sub(1,1) ~= '-' then
            local size = vim.fn.getfsize(a)
            if size > threshold then
                return true
            end
        end
    end
    return false
end

vim.g.bigfile_mode = is_big_file()


-- set color scheme --
vim.cmd('syntax on')
vim.cmd('colorscheme sorbet')

-- set leader key --
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

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
map('n', '<Tab>'     , ':tabnext<CR>'    , nore_silent)
map('n', '<S-Tab>'   , ':tabprevious<CR>', nore_silent)
map('n', '<Leader>tw', ':tabnew '        , nore_nosilent)

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
map('n', '<Leader>vs'  , ':vsplit<CR>', nore_silent  )
map('n', '<Leader>hs'  , ':split<CR>' , nore_silent  )
map('n', '<Leader>vw'  , ':vsplit '   , nore_nosilent)
map('n', '<Leader>hw'  , ':split '    , nore_nosilent)
map('n', '<Leader><BS>', ':close<CR>' , nore_silent  )
map('n', '<right>'     , '<C-w><'     , nore_silent  )
map('n', '<left>'      , '<C-w>>'     , nore_silent  )
map('n', '<up>'        , '<C-w>+'     , nore_silent  )
map('n', '<down>'      , '<C-w>-'     , nore_silent  )

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

    if old == '' then
        vim.api.nvim_echo({ { '=> Warning : No visual selection', 'WarningMsg' } }, false, {})
        return
    end

    local new = vim.fn.input(('replace /%s/ to: '):format(old))
    if new == nil or new == '' then
        vim.api.nvim_echo({ { '=> Warning : Specify a new word! rpl command was canceled', 'WarningMsg' } }, false, {})
        return
    end

    local rep = vim.fn.escape(new, [[\/\&]])

    vim.cmd(('%%s/%s/%s/g'):format(old, rep))
end
vim.api.nvim_create_user_command('Rpl', replace_selected, {range = true})
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

    local out = {'%#MainWinbarCrumb#'}
    table.insert(out, '    ')
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

local function is_floating(win)
    win = win or 0
    local cfg = vim.api.nvim_win_get_config(win)
    return cfg.relative ~= ''
end

local function set_winbar()
    if is_floating(0) then
        return
    end

    if vim.bo.buftype ~= '' then
        return
    end

    vim.wo.winbar = '%{%v:lua.FileLocationWinBar()%}'
end

vim.api.nvim_create_autocmd(
    {
        'WinEnter',
        'BufWinEnter',
        'TabEnter',
        'FileType',
    },
    {
        group = vim.api.nvim_create_augroup('MyWinbar', { clear = true }),
        callback = function()
            set_winbar()
        end,
    }
)




