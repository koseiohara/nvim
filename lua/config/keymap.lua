



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




