local M = {}

function M.get_file_name()
    return M.normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), vim.fn.getcwd())
end

function M.normalize_path(file_name, root)
    -- is plenary really necessary?
    return require("plenary.path"):new(file_name):make_relative(root)
end

function M.display_name(file_name)
    local trimmed = false
    while #file_name > 60 do
        file_name = file_name:sub(10)
        trimmed = true
    end
    if trimmed then
        file_name = "..." .. file_name
    end
    return file_name
end

return M
