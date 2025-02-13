local M = {}

function M.get_buf_name()
    return M.normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), vim.fn.getcwd())
end

function M.normalize_path(buf_name, root)
    -- is plenary really necessary?
    return require("plenary.path"):new(buf_name):make_relative(root)
end

function M.display_name(buf_name)
    local trimmed = false
    while #buf_name > 60 do
        buf_name = buf_name:sub(10)
        trimmed = true
    end
    if trimmed then
        buf_name = "..." .. buf_name
    end
    return buf_name
end

return M
