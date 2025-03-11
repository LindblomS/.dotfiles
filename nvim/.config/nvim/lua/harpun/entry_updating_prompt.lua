local logger = require("harpun.logger")

local function set_keymaps(list, index, new_entry, buf, win_id)
    vim.keymap.set("n", "y", function()
        list:add_or_update(index, new_entry)
        vim.api.nvim_win_close(win_id, true)
    end, { buffer = buf, silent = true })

    vim.keymap.set("n", "n", function()
        vim.api.nvim_win_close(win_id, true)
    end, { buffer = buf, silent = true })

    vim.keymap.set("n", "<esc>", function()
        vim.api.nvim_win_close(win_id, true)
    end, { buffer = buf, silent = true })
end

local M = {}

function M.prompt(list, index, new_entry)
    if not list then
        logger.error("list was nil")
    end

    if not index or index < 1 then
        logger.error("index was nil or less than 1")
    end

    if not new_entry then
        logger.error("new_entry was nil")
    end

    local window_factory = require("harpun.window_factory")
    local util = require("harpun.util")

    local buf = vim.api.nvim_create_buf(false, true)
    local win = window_factory.create(buf, "File exists at index", list)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        string.format("Replace file %s?", util.display_name(list:get()[index].file_name)),
        "y (yes), n (no)"
    })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
    set_keymaps(list, index, new_entry, buf, win)
end

return M
