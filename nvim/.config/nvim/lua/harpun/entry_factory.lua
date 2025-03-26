local function normalize_path(file_name, root)
    return require("plenary.path"):new(file_name):make_relative(root)
end

local function get_file_name()
    return normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), vim.fn.getcwd())
end

local M = {}

function M.create()
    return {
        file_name = get_file_name(),
    }
end

return M
