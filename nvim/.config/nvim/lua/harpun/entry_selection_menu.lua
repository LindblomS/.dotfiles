local logger = require("harpun.logger")

local function get_entry_names(list)
    local entry_names = {}
    local util = require("harpun.util")
    for i, entry in ipairs(list:get()) do
        entry_names[i] = util.display_name(entry.file_name)
    end
    return entry_names
end

local function select(entry)
    local buf = vim.fn.bufnr(entry.file_name)
    if buf == -1 then
        buf = vim.fn.bufadd(entry.file_name)
    end
    if not vim.api.nvim_buf_is_loaded(buf) then
        vim.fn.bufload(buf)
        vim.api.nvim_set_option_value("buflisted", true, {
            buf = buf,
        })
    end
    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_feedkeys("zz", "n", false)
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

function M:open(list)
    if not list then
        logger.error("list was nil")
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
        local entry = list:get()[index]
        if entry then
            select(list:get()[index])
        end
    end, { buffer = buf, silent = true })


    -- vim.keymap.set("n", "dd", "<nop>")
    vim.keymap.set("n", "dd", function()
        local index = vim.fn.line(".")
        list:remove(index)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, get_entry_names(list))
    end, { buffer = buf, silent = true, remap = true })

    vim.api.nvim_set_option_value("buftype", "acwrite", { buf = buf })
    vim.api.nvim_set_option_value("number", true, { win = win })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, get_entry_names(list))
end

return M
