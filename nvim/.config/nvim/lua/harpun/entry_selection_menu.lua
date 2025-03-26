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

-- todo: rename to better name
local function draw(buf, list)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, get_entry_names(list))
end

local M = {}

function M.new(self, list)
    self._list = list or error("list was nil")
    self._buf = nil
    self._closing = false
    return self
end

M.close = function(self)
    if self._closing then
        return
    end

    self._closing = true
    self._list:save()
    if vim.api.nvim_buf_is_valid(self._buf) then
        vim.api.nvim_buf_delete(self._buf, { force = true })
    end
end

M.open = function(self)
    local list = self._list

    local buf = vim.api.nvim_create_buf(false, true)
    local win = require("harpun.window_factory").create(buf, "harpun", list)
    self._buf = buf
    self._closing = false

    -- close
    vim.keymap.set("n", "<esc>", function()
        self:close()
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Close menu"
    })

    -- select
    vim.keymap.set("n", "<cr>", function()
        local index = vim.fn.line(".")
        self:close()
        local entry = list:get()[index]
        if entry then
            select(list:get()[index])
        end
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Select entry in menu",
    })

    -- todo: add select by number

    -- move up
    -- todo: I want this to be <C-Up>, but it doesn't work for some reason.
    -- hint, might have to do with keyboard mapping C-Up/Down is page up and down.
    vim.keymap.set("n", "<S-Up>", function()
        local index = vim.fn.line(".")
        -- we're at the first line
        if index == 1 then
            return
        end
        list:move(index, index - 1)
        draw(buf, list)
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1]
        local col = cursor[2]
        vim.api.nvim_win_set_cursor(0, { row - 1, col })
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Move entry up one step",
    })

    -- move down
    vim.keymap.set("n", "<S-Down>", function()
        local line_count = vim.api.nvim_buf_line_count(0)
        local index = vim.fn.line(".")
        -- we're at the last line
        if index >= line_count then
            return
        end
        list:move(index, index + 1)
        draw(buf, list)
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1]
        local col = cursor[2]
        vim.api.nvim_win_set_cursor(0, { row + 1, col })
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Move entry down one step",
    })

    -- remove
    vim.keymap.set("n", "dd", function()
        local index = vim.fn.line(".")
        list:remove(index)
        draw(buf, list)
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Remove entry"
    })

    vim.api.nvim_set_option_value("buftype", "acwrite", { buf = buf })
    vim.api.nvim_set_option_value("number", true, { win = win })
    draw(buf, list)
end

return M
