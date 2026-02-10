


return {
    {
        'williamboman/mason.nvim',
        opts = {},
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
        opts = {
            ensure_installed = {
                'fortls',
                'pylsp',
                'lua_ls',
                'texlab',
                'ltex',
            },
            automatic_installation = true,
        },
    },
}




