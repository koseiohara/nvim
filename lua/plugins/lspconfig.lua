

return {
    'neovim/nvim-lspconfig',
 
    config = function()

        local tex_show_warnings = false
        vim.keymap.set("i", "<C-n>", "<Nop>", { silent = true })
        vim.keymap.set("i", "<C-p>", "<Nop>", { silent = true })

        vim.diagnostic.config({
            virtual_text = false,
            underline    = true,
            signs        = true,
            update_in_insert = false,
            severity_sort    = true ,
        })

        local function set_tex_diagnostic_handlers(bufnr, show_warnings)
            local min = show_warnings and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR
            vim.diagnostic.config({
                underline = { severity = { min = min } },
                signs = { severity = { min = min } },
            }, bufnr)
        end

        -- =========================================
        -- 2) Global toggles (language-agnostic)
        -- =========================================
        vim.api.nvim_create_user_command("DiagVirtualTextToggle", function()
            local cur = vim.diagnostic.config().virtual_text
            vim.diagnostic.config({
                virtual_text = not cur
            })
        end, {})

        -- vim.lsp.handlers["textDocument/completion"] = function()
        -- end
        vim.lsp.handlers["textDocument/codeAction"] = function()
        end

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

        local function tex_root(fname)
            return vim.fs.root(fname, { ".latexmkrc", ".git" })
        end

        vim.lsp.config('texlab', {
            on_attach = on_attach,
            filetypes = { "tex", "plaintex", "bib" },
            root_dir = tex_root,
            settings = {
                texlab = {
                    build = {
                        onSave = false,
                        forwardSearchAfter = false,
                    },

                    diagnostics = {
                        ignoredPatterns = {
                            "Underfull \\\\hbox",
                            "Overfull \\\\hbox",
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
        -- 6) ltex-ls（ltex）
        -- ==========================================
        vim.lsp.config('ltex', {
            on_attach = on_attach,
            filetypes = { "tex", "plaintex", "bib" },
            root_dir = tex_root,
            settings = {
                ltex = {
                    language = "en-US",
                    -- dictionary = { ["en-US"] = { "quasigeostrophic", ... } },
                    -- disabledRules = { ["en-US"] = { "MORFOLOGIK_RULE_EN_US" } },
                },
            },
        })


        vim.lsp.enable({
            'texlab',
            'ltex',
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "tex", "plaintex", "bib" },
            callback = function(args)
                set_tex_diagnostic_handlers(args.buf, tex_show_warnings)
            end,
        })
    end,
}



