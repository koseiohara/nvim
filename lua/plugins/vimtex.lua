

return {
    'lervag/vimtex',
    lazy = false,
    init = function()
        if vim.fn.has("macunix") ~= 1 then
            return
        end
        vim.g.maplocalleader         = " "
        vim.g.vimtex_view_method     = "skim"
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_quickfix_mode   = 1
        vim.g.vimtex_compiler_latexmk = {
            options = {
                "-pdfdvi",
                "-e", '$latex=q/platex %O -synctex=1 -interaction=nonstopmode -file-line-error %S/',
                "-e", '$bibtex=q/pbibtex %O %B/',
                "-e", '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/',
                "-e", '$makeindex=q/mendex %O -o %D %S/',
                "-e", '$dvipdf=q/dvipdfmx %O -o %D %S/',
            },
        }

        -- local function is_tex_or_cls()
        --     local name = vim.api.nvim_buf_get_name(0)
        --     return name:match("%.tex$") ~= nil or name:match("%.cls$")
        -- end

        -- Open SKim Automatically
        local function open_pdf()
            if vim.fn.exists(":VimtexView") == 2 then
                vim.cmd("VimtexView")
            end
        end

        local function compile()
            if vim.fn.exists(":VimtexCompileSS") == 2 then
                vim.cmd("VimtexCompileSS")
            elseif vim.fn.exists(":VimtexCompile") == 2 then
                vim.cmd("VimtexCompile")
            end
        end

        local group = vim.api.nvim_create_augroup("tex_file", { clear = true })

        -- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        --     group   = group,
        --     pattern = { "*.tex", "*.cls" },
        --     callback = function()
        --         vim.defer_fn(open_pdf, 50)
        --     end,
        -- })

        -- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        --     group = group,
        --     pattern = { "*.tex", "*.cls" },
        --     callback = function(args)
        --         vim.keymap.set("n", "<leader>lv", open_pdf, {
        --             buffer = args.buf,
        --             silent = true,
        --             desc = "VimTeX: View in Skim",
        --         })
        --     end,
        -- })

        -- Check wether vim is being closed
        local vimtex_exiting = false
        vim.api.nvim_create_autocmd({"VimLeavePre" }, {
            group = group,
            callback = function()
                vimtex_exiting = true
            end,
        })
        
        -- auto compiler (only if vim is not being closed)
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            group = group,
            pattern = { "*.tex", "*.cls" },
            callback = function()
                if vimtex_exiting then
                    return
                end
                compile()
            end,
        })
    end,
}



