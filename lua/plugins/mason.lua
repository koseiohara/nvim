


return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        opts = {
            ensure_installed = { "texlab", "ltex" }, -- mason の登録名は環境で "ltex-ls" 表記の場合あり
            automatic_installation = true,
        },
    },
}




