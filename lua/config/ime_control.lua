

local CONTROLLER = 'macism'
local IM_EN      = 'com.apple.keylayout.ABC'

vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
        vim.fn.system(CONTROLLER .. " " .. IM_EN)
    end,
})



