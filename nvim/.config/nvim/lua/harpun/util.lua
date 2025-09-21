local M = {}

function M.get_file()
    local cwd = vim.fn.getcwd()
    local file_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    local relative_path = string.gsub(file_path, cwd, "")
    -- Trim any precceding / or \
    relative_path = string.sub(relative_path, 2)
    return relative_path
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
