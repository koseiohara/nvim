


-- local function digits(n)
--     n = math.floor(math.abs(n or 0))
--     if n < 10 then
--         return 1
--     end
--     return math.floor(math.log10(n)) + 1
-- end

-- local function lnum_digits()
--     local tot    = vim.fn.line('$')
--     local ldigit = digits(tot)

--     local h    = vim.fn.winheight(0)
--     local wrel = 3

--     return ldigit, wrel
-- end


-- _G.statuscolumnNumber = function()
--     local win = vim.api.nvim_get_current_win()
--     local ldigit, wrel = lnum_digits()

--     local anum = vim.v.lnum
--     local rnum = vim.v.relnum

--     return string.format(' %' .. ldigit .. 'd %' .. wrel .. 'd', anum, rnum)
-- end

vim.opt.number         = true
vim.opt.relativenumber = true

-- vim.opt.statuscolumn = '%s%C%{v:lua.statuscolumnNumber()}'


