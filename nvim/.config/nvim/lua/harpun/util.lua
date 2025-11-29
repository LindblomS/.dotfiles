local M = {}

function M.get_file()
    return vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
end

function M.get_file_display_name(file)
    local trimmed = false
    while #file > 60 do
        file = file:sub(10)
        trimmed = true
    end
    if trimmed then
        file = "..." .. file
    end
    return file
end

return M
