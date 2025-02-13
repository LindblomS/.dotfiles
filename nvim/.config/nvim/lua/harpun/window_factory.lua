local M = {}

function M.create(buf, title, list)
    if not buf then
        error("buf was nil")
    end
    if not list then
        error("list was nil")
    end

    local util = require("harpun.util")
    local height = 8
    local width = 0

    -- Set width to the longest display name
    for _, entry in pairs(list:get()) do
        local display_name = util.display_name(entry.buf_name)
        if #display_name > width then
            width = #display_name
        end
    end

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        title = title,
        title_pos = "left",
        row = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        width = width + 25,
        height = height,
        style = "minimal",
        border = "single",
    })
    return win
end

return M
