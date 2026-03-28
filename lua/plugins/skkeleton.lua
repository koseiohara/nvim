

return {
    {
        'vim-denops/denops.vim',
        cond = function()
            return vim.fn.executable('deno') == 1
        end,
        lazy = true,
    },
    {
        'vim-skk/skkeleton',
        dependencies = {
            'vim-denops/denops.vim',
        },
        ft = { 'markdown', 'text', 'tex' },
        cond = function()
            return vim.fn.executable('deno') == 1
        end,
        init = function()
            local function file_exists(path)
                return vim.fn.filereadable(vim.fn.expand(path)) == 1
            end

            local function build_global_dictionaries()
                local dicts = {}

                local candidates = {
                      '~/.config/dict/SKK-JISYO.L',
                }

                for _, path in ipairs(candidates) do
                    if file_exists(path) then
                        table.insert(dicts, vim.fn.expand(path))
                        break
                    end
                end

                -- Emoji Dictionary
                local emoji_dict = '~/.config/dict/SKK-JISYO.emoji'
                if file_exists(emoji_dict) then
                    table.insert(dicts, vim.fn.expand(emoji_dict))
                end

                return dicts
            end

            vim.api.nvim_create_autocmd('User', {
                pattern = 'skkeleton-initialize-pre',
                callback = function()
                    vim.fn['skkeleton#config']({
                        eggLikeNewline = true,
                        globalDictionaries = build_global_dictionaries(),
                        userDictionary = vim.fn.expand('~/.config/skkeleton/skkeleton-user-dict'),
                        registerConvertResult = true,
                        immediatelyDictionaryRW = true,
                        showCandidatesCount = 4,
                        markerHenkan = '▽',
                        markerHenkanSelect = '▼',
                        keepState = false,
                        keepMode = false,
                        setUndoPoint = false,
                        kanaTable = 'rom',
                        sources = { 'skk_dictionary' },
                    })
                end,
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'markdown', 'text', 'tex' },
                callback = function(args)
                    local opts = { buffer = args.buf, silent = true }
                    vim.keymap.set({'i'}, '<C-j>', '<Plug>(skkeleton-enable)' , opts)
                    vim.keymap.set({'i'}, '<C-k>', '<Plug>(skkeleton-disable)', opts)
                end,
            })
        end,
    },
}


