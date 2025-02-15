local function get_entry_names(list)
    local entry_names = {}
    local util = require("harpun.util")
    for i, entry in ipairs(list:get()) do
        entry_names[i] = util.display_name(entry.file_name)
    end
    return entry_names
end

local M = {
    buf = nil,
    closing = false,
}

function M:close()
    if self.closing then
        return
    end

    self.closing = true
    if vim.api.nvim_buf_is_valid(self.buf) then
        vim.api.nvim_buf_delete(self.buf, { force = true })
    end
end

function M:open(list, harpun)
    if not list then
        error("list was nil")
    end
    if not harpun then
        error("harpun was nil")
    end

    local buf = vim.api.nvim_create_buf(false, true)
    local win = require("harpun.window_factory").create(buf, "harpun", list)
    self.buf = buf
    self.closing = false

    vim.keymap.set("n", "<esc>", function()
        self:close()
    end, { buffer = buf, silent = true })

    vim.keymap.set("n", "<cr>", function()
        local index = vim.fn.line(".")
        self:close()
        harpun:select(index)
    end, { buffer = buf, silent = true })

    vim.api.nvim_set_option_value("buftype", "acwrite", { buf = buf })
    vim.api.nvim_set_option_value("number", true, { win = win })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, get_entry_names(list))
end

return M
