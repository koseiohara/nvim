
-- Note
-- node is needed to install pyright

return {
    'neovim/nvim-lspconfig',
 
    config = function()

        local tex_show_warnings     = false
        local fortran_show_warnings = false
        local python_show_warnings  = false

        vim.keymap.set('i', '<C-n>', '<Nop>', { silent = true })
        vim.keymap.set('i', '<C-p>', '<Nop>', { silent = true })

        vim.diagnostic.config({
            virtual_text = false,
            underline    = true,
            signs        = true,
            update_in_insert = false,
            severity_sort    = true ,
        })

        -- =========================================
        --  Diagnostic Threshold
        -- =========================================
        local function set_fortran_diagnostic_handlers(bufnr, show_warnings)
            local min = show_warnings and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR
            vim.diagnostic.config({
                underline = { severity = { min = min } },
                signs     = { severity = { min = min } },
            }, bufnr)
        end

        local function set_python_diagnostic_handlers(bufnr, show_warnings)
            local min = show_warnings and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR
            vim.diagnostic.config({
                underline = { severity = { min = min } },
                signs     = { severity = { min = min } },
            }, bufnr)
        end

        local function set_tex_diagnostic_handlers(bufnr, show_warnings)
            local min = show_warnings and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR
            vim.diagnostic.config({
                underline = { severity = { min = min } },
                signs     = { severity = { min = min } },
            }, bufnr)
        end

        -- =========================================
        --  Global toggles (language-agnostic)
        -- =========================================
        vim.api.nvim_create_user_command('DiagVirtualTextToggle', function()
            local cur = vim.diagnostic.config().virtual_text
            vim.diagnostic.config({
                virtual_text = not cur
            })
        end, {})

        -- vim.lsp.handlers['textDocument/completion'] = function()
        -- end
        vim.lsp.handlers['textDocument/codeAction'] = function()
        end

        -- =========================================
        --  Kill LSP Annoying UI
        -- =========================================
        local function disable_ui_capabilities(client, bufnr)
            client.server_capabilities.completionProvider = nil
            client.server_capabilities.codeActionProvider = false
            -- client.server_capabilities.hoverProvider = false
            -- client.server_capabilities.signatureHelpProvider = nil
            vim.bo[bufnr].omnifunc = nil
        end

        local function on_attach(client, bufnr)
            disable_ui_capabilities(client, bufnr)
            -- set_tex_diagnostic_handlers(bufnr, tex_show_warnings)
        end

        -- =========================================
        --  Root Directory
        -- =========================================
        local function fortran_root(fname)
            return vim.fs.root(fname, { '.git', 'Makefile' })
        end

        local function python_root(fname)
            return vim.fs.root(fname, { "pyrightconfig.json", "pyproject.toml", ".git" })
        end

        local function tex_root(fname)
            return vim.fs.root(fname, { '.latexmkrc', '.git' })
        end

        -- =========================================
        --  LSP Server Setting for Fortran
        -- =========================================
        vim.lsp.config('fortls', {
            on_attach = on_attach,
            filetypes = { 'fortran' },
            root_dir  = fortran_root,

            settings = {
                fortls = {
                },
            },
        })

        -- =========================================
        --  LSP Server Setting for Python
        -- =========================================
        vim.lsp.config('pyright', {
            on_attach = on_attach,
            filetypes = { 'python' },
            root_dir  = python_root,

            settings = {
                pyright = {
                },
            },
        })

        -- =========================================
        --  LSP Server Setting for LaTeX
        -- =========================================
        vim.lsp.config('texlab', {
            on_attach = on_attach,
            filetypes = { 'tex', 'plaintex', 'bib' },
            root_dir = tex_root,
            settings = {
                texlab = {
                    build = {
                        onSave = false,
                        forwardSearchAfter = false,
                    },

                    diagnostics = {
                        ignoredPatterns = {
                            'Underfull \\\\hbox',
                            'Overfull \\\\hbox',
                        },
                    },

                    chktex = {
                        onOpenAndSave = false,
                        onEdit = false,
                    },
                },
            },
        })

        -- ==========================================
        --  LSP Server Setting for English
        -- ==========================================
        vim.lsp.config('ltex', {
            on_attach = on_attach,
            filetypes = { 'tex', 'plaintex', 'bib' },
            root_dir = tex_root,
            settings = {
                ltex = {
                    language = 'en-US',
                    -- dictionary = { ['en-US'] = { 'quasigeostrophic', ... } },
                    -- disabledRules = { ['en-US'] = { 'MORFOLOGIK_RULE_EN_US' } },
                },
            },
        })


        vim.lsp.enable({
            'fortls',
            'pyright',
            'texlab',
            'ltex',
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'fortran' },
            callback = function(args)
                set_fortran_diagnostic_handlers(args.buf, fortran_show_warnings)
            end,
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'python' },
            callback = function(args)
                set_python_diagnostic_handlers(args.buf, python_show_warnings)
            end,
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'tex', 'plaintex', 'bib' },
            callback = function(args)
                set_tex_diagnostic_handlers(args.buf, tex_show_warnings)
            end,
        })
    end,
}



