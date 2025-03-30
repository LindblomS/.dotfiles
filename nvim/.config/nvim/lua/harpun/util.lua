local M = {}

local function normalize_path(file, root)
    return require("plenary.path"):new(file):make_relative(root)
end

function M.get_file()
    return normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), vim.fn.getcwd())
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
