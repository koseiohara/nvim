

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
        local telescope = require('telescope')
        telescope.setup({})
        local builtin   = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep , {})
        vim.keymap.set('n', '<leader>fG', builtin.grep_string, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers   , {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags , {})
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
        vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
    end,
}

