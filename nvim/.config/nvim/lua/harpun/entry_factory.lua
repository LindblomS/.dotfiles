local function normalize_path(buf_name, root)
    return require("plenary.path"):new(buf_name):make_relative(root)
end

local function get_buf_name()
    return normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), vim.fn.getcwd())
end

local M = {}

function M.create(key)
    if not key or key == "" then
        error("key was nil or empty")
    end

    local buf_name = get_buf_name()
    return {
        buf_name = buf_name,
        key = key,
    }
end

return M
