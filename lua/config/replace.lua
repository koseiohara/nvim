



local function replace_selected()
    local old = vim.fn.getreg('/') or ''

    if old == '' then
        vim.api.nvim_echo({ { '=> Warning : No visual selection', 'WarningMsg' } }, false, {})
        return
    end

    local new = vim.fn.input(('replace %s to: '):format(old))
    if new == nil or new == '' then
        vim.api.nvim_echo({ { '=> Warning : Specify a new word! rpl command was canceled', 'WarningMsg' } }, false, {})
        return
    end

    local rep = vim.fn.escape(new, [[\/\&]])

    vim.cmd(('%%s/%s/%s/g'):format(old, rep))
end
vim.api.nvim_create_user_command('Rpl', replace_selected, {range = true})
vim.cmd('cabbrev rpl Rpl')


