local M = {}

function M.create(buf, title, items)
    local height = 8
    local width = 0

    for _, value in pairs(items) do
        if #value.display_name > width then
            width = #value.display_name
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
