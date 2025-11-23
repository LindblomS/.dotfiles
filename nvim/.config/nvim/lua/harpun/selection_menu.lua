local function get_file_display_names(files)
    local names = {}
    local util = require("harpun.util")
    for i, file in ipairs(files) do
        names[i] = util.get_file_display_name(file)
    end
    return names
end

local function list_files_in_buf(buf, files)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, get_file_display_names(files))
end

local function create_window(buf, title, width)
    local height = 8
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

local M = {}

function M.new(self, harpun)
    assert(harpun)
    self._harpun = harpun
    self._buf = nil
    self._closing = false
    return self
end

function M.select_by_index(self, index)
    self:close()
    local file = self._harpun:get()[index]
    if file then
        self._harpun.select(file)
    end
end

function M.close(self)
    if self._closing then
        return
    end

    self._closing = true
    self._harpun:save()
    if vim.api.nvim_buf_is_valid(self._buf) then
        vim.api.nvim_buf_delete(self._buf, { force = true })
    end
    self._buf = nil
end

function M.open(self)
    local util = require("harpun.util")
    local files = self._harpun:get()

    -- Set window width to the longest display name
    local win_width = 0
    for _, file in pairs(files) do
        local display_name = util.get_file_display_name(file)
        if #display_name > win_width then
            win_width = #display_name
        end
    end

    local listed = false
    local scratch = true
    local buf = vim.api.nvim_create_buf(listed, scratch)
    local win = create_window(buf, "harpun", win_width)
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
        M:select_by_index(index)
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Select file in menu on current row",
    })

    -- select by index
    for i = 0, #files do
        vim.keymap.set("n", tostring(i), function()
            M:select_by_index(i)
        end, {
            buffer = buf,
            silent = true,
            desc = string.format("Harpun: Select file in menu with index %d", i),
        })
    end

    -- move up
    -- todo: I want this to be <C-Up>, but it doesn't work for some reason.
    vim.keymap.set("n", "<S-Up>", function()
        local index = vim.fn.line(".")
        -- we're at the first line
        if index == 1 then
            return
        end
        self._harpun:move(index, index - 1)
        list_files_in_buf(buf, files)
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1]
        local col = cursor[2]
        vim.api.nvim_win_set_cursor(0, { row - 1, col })
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Move file up one step",
    })

    -- move down
    vim.keymap.set("n", "<S-Down>", function()
        local line_count = vim.api.nvim_buf_line_count(0)
        local index = vim.fn.line(".")
        -- we're at the last line
        if index >= line_count then
            return
        end
        self._harpun:move(index, index + 1)
        list_files_in_buf(buf, files)
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1]
        local col = cursor[2]
        vim.api.nvim_win_set_cursor(0, { row + 1, col })
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Move file down one step",
    })

    -- remove
    vim.keymap.set("n", "dd", function()
        local index = vim.fn.line(".")
        self._harpun:remove(index)
        list_files_in_buf(buf, files)
    end, {
        buffer = buf,
        silent = true,
        desc = "Harpun: Remove file"
    })

    vim.api.nvim_set_option_value("buftype", "acwrite", { buf = buf })
    vim.api.nvim_set_option_value("number", true, { win = win })
    list_files_in_buf(buf, files)
end

return M
