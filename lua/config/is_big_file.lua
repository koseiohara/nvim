

local function is_big_file(threshold)
    threshold = threshold or (50*1024*1024)
    for _, a in ipairs(vim.v.argv) do
        if a:sub(1,1) ~= '-' then
            local size = vim.fn.getfsize(a)
            if size > threshold then
                return true
            end
        end
    end
    return false
end

vim.g.bigfile_mode = is_big_file()


