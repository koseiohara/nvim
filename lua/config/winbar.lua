



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

    dir = dir:gsub('/$', '')

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




