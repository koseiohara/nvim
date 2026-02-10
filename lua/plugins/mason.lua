


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
                'pyright',
                'texlab',
                'ltex',
            },
            automatic_installation = true,
        },
    },
}




