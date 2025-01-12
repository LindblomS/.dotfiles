local M = {}

function M.get_bufname()
    local name = M.normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), vim.fn.getcwd())
    local is_trimmed = false
    while #name > 60 do
        name = name:sub(10)
        is_trimmed = true
    end
    if is_trimmed then
        name = "..." .. name
    end
    return name
end

function M.normalize_path(bufname, root)
    -- is plenary really necessary?
    return require("plenary.path"):new(bufname):make_relative(root)
end

return M
