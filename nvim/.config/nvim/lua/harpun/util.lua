local M = {}

function M.get_buf_name()
    return M.normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), vim.fn.getcwd())
end

function M.normalize_path(buf_name, root)
    -- is plenary really necessary?
    return require("plenary.path"):new(buf_name):make_relative(root)
end

return M
