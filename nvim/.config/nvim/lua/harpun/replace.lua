local window_factory = require("harpun.window_factory")
local M = {}

local function set_keymaps(context, buf, win_id)
    vim.keymap.set("n", "y", function()
        context.items[context.index] = context.new_item
        vim.api.nvim_win_close(win_id, true)
    end, { buffer = buf, silent = true })

    vim.keymap.set("n", "n", function()
        vim.api.nvim_win_close(win_id, true)
    end, { buffer = buf, silent = true })

    vim.keymap.set("n", "<esc>", function()
        vim.api.nvim_win_close(win_id, true)
    end, { buffer = buf, silent = true })
end

local function prompt(context)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = window_factory.create(buf, "File already harpun:ed", context.items)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        context.item.display_name .. " is already harpun:ed",
        "replace? y (yes), n (no)"
    })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
    set_keymaps(context, buf, win)
end

function M.display_prompt(item, new_item, items, index)
    prompt({ item = item, new_item = new_item, items = items, index = index })
end

return M
