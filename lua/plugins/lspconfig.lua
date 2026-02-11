
return {
    'neovim/nvim-lspconfig',
 
    config = function()

        local fortran_show_warnings = false
        local python_show_warnings  = false
        local lua_show_warnings     = false
        local tex_show_warnings     = false
        local ltex_show_warnings    = true

        vim.keymap.set('i', '<C-n>', '<Nop>', { silent = true })
        vim.keymap.set('i', '<C-p>', '<Nop>', { silent = true })

        vim.diagnostic.config({
            virtual_text = true,
            underline    = true,
            signs        = true,
            update_in_insert = false,
            severity_sort    = true ,
        })

        -- =========================================
        --  Diagnostic Threshold
        -- =========================================
        local function set_standard_diagnostic_handlers(client, show_warnings)
            local min = show_warnings and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR

            local ns = nil
            if client and client.id then
                local ok, v = pcall(function()
                    -- return vim.lsp.diagnostic.get_namespace(client.id)
                    if vim.lsp.diagnostic and vim.lsp.diagnostic.get_namespace then
                        return vim.lsp.diagnostic.get_namespace(client.id)
                    end
                    return nil
                end)
                if ok and type(v) == "number" then
                    ns = v
                end
            end

            local opts = {
                underline = { severity = { min = min } },
                signs     = { severity = { min = min } },
            }

            if not ns then
                return
            end
            vim.diagnostic.config(opts, ns)
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
            if client.name == 'fortls' then
                set_standard_diagnostic_handlers(client, fortran_show_warnings)
            elseif client.name == 'pylsp' then
                set_standard_diagnostic_handlers(client, python_show_warnings)
            elseif client.name == 'lua_ls' then
                set_standard_diagnostic_handlers(client, lua_show_warnings)
            elseif client.name == 'texlab' then
                set_standard_diagnostic_handlers(client, tex_show_warnings)
            elseif client.name == 'ltex' then
                set_standard_diagnostic_handlers(client, ltex_show_warnings)
            end
        end

        -- =========================================
        --  Root Directory
        -- =========================================
        local function root_maker(flags)
            return function(bufnr, on_dir)
                local fname = vim.api.nvim_buf_get_name(bufnr)
                local root = vim.fs.root(fname, flags) or vim.fs.dirname(fname)
                on_dir(root)
            end
        end

        local function fortran_root(bufnr, fname)
            return vim.fs.root(fname, { '.git', 'Makefile' }) or vim.fs.dirname(fname)
        end

        local function python_root(fname)
            return vim.fs.root(fname, { 'pyproject.toml', 'pyrightconfig.json', '.git' }) or vim.fs.dirname(fname)
        end

        local function lua_root(fname)
            return vim.fs.root(fname, { '.luarc.json', '.luarc.jsonc', '.git' }) or vim.fs.dirname(fname)
        end

        local function tex_root(fname)
            return vim.fs.root(fname, { '.latexmkrc', '.git' }) or vim.fs.dirname(fname)
        end

        do
            local orig = vim.lsp.handlers["window/showMessage"]
        
            vim.lsp.handlers["window/showMessage"] = function(err, result, ctx, config)
                local client = vim.lsp.get_client_by_id(ctx.client_id)
        
                if client and client.name == "fortls" and result then
                    if result.type == vim.lsp.protocol.MessageType.Info then
                        return
                    end

                    if result.type == vim.lsp.protocol.MessageType.Warning then
                        local msg = result.message or ""
                        if msg:match("Failed to update the fortls") then
                            return
                        end
                    end
                    -- local msg = result.message or ""
                    -- if msg == "fortls initialization complete" or msg == "fortls debugging enabled" then
                    --     return
                    -- end
                end
        
                return orig(err, result, ctx, config)
            end
        end

        -- =========================================
        --  LSP Server Setting for Fortran
        -- =========================================
        local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
        vim.lsp.config('fortls', {
            cmd = {
                mason_bin .. "/fortls",
                -- "--debug_log",
                -- "--disable_autoupdate",
                "--notify_init",
                "--hover_signature",
                "--hover_language=fortran",
                "--use_signature_help",
            },
            on_attach = on_attach,
            filetypes = { 'fortran' },
            root_dir  = root_maker({ '.git', 'Makefile' }),

            settings = {
                fortls = {
                    disable_diagnostics = false,
                },
            },
        })

        -- =========================================
        --  LSP Server Setting for Python
        -- =========================================
        vim.lsp.config('pylsp', {
            on_attach = on_attach,
            filetypes = { 'python' },
            root_dir  = root_maker({ 'pyproject.toml', 'pyrightconfig.json', '.git' }),

            settings = {
                pylsp = {
                    plugins = {
                        pyflakes = {
                            enabled = true,
                        },

                        -- =====================
                        --  Disables
                        -- =====================
                        pycodestyle = {
                            enabled = false,
                        },

                        flake8 = {
                            enabled = false,
                        },

                        mccabe = {
                            enabled = false,
                        },

                        pylint = {
                            enabled = false,
                        },

                        autopep8 = {
                            enabled = false,
                        },

                        yapf = {
                            enabled = false,
                        },

                        black = {
                            enabled = false,
                        },

                        jedi_completion = {
                            enabled = false,
                        },

                        jedi_definition = {
                            enabled = false,
                        },

                        jedi_hover = {
                            enabled = false,
                        },

                        jedi_references = {
                            enabled = false,
                        },

                        jedi_signature_help = {
                            enabled = false,
                        },

                        rope_autoimport = {
                            enabled = false,
                        },
                    },
                },
            },
        })

        -- =========================================
        --  LSP Server Setting for Lua
        -- =========================================
        vim.lsp.config('lua_ls', {
            on_attach = on_attach,
            filetypes = { 'lua' },
            root_dir  = root_maker({ '.luarc.json', '.luarc.jsonc', '.git' }),

            settings = {
                Lua = {
                    diagnostics = {
                        -- Lua for neovim setting
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        -- =========================================
        --  LSP Server Setting for LaTeX
        -- =========================================
        vim.lsp.config('texlab', {
            on_attach = on_attach,
            filetypes = { 'tex', 'plaintex', 'bib' },
            root_dir = root_maker({ '.latexmkrc', '.git' }),
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
            root_dir = root_maker({ '.latexmkrc', '.git' }),
            settings = (function()
                local uv = vim.uv or vim.loop

                local function dict_exist(filename)
                    filename = vim.fn.expand(filename)
                    return uv.fs_stat(filename) and filename or nil
                end

                local en_dict = dict_exist('~/.config/ltex/dictionary.en-US.txt')
                -- local ja_dict = dict_exist('~/.config/ltex/dictionary.ja.txt')

                local ltex_settings = {
                    language = 'en-US',
                    -- language = 'en-US,ja',   -- If Japanese dictionary is needed
                }

                local dict = {}
                if en_dict then
                    dict['en-US'] = en_dict
                end

                -- if ja_dict then
                --     dict['ja'] = ja_dict
                -- end

                if next(dict) ~= nil then
                    ltex_settings.dictionary = dict
                end

                return {ltex = ltex_settings}
            end)(),
        })


        vim.lsp.enable({
            'fortls',
            'pylsp',
            'lua_ls',
            'texlab',
            'ltex',
        })

    end,
}



