--- A file navigation plugin inspired by harpoon
local M = {}

function M.setup()
    local repository = require("harpun.repository").new()
    M._list = require("harpun.list").new(repository)

    vim.keymap.set("n", "<leader>1", function() M:add(1, "1") end)
    vim.keymap.set("n", "<leader>2", function() M:add(2, "2") end)
    vim.keymap.set("n", "<leader>3", function() M:add(3, "3") end)
    vim.keymap.set("n", "<leader>4", function() M:add(4, "4") end)

    vim.keymap.set("n", "<C-1>", function() M:select(1) end)
    vim.keymap.set("n", "<C-2>", function() M:select(2) end)
    vim.keymap.set("n", "<C-3>", function() M:select(3) end)
    vim.keymap.set("n", "<C-4>", function() M:select(4) end)

    vim.keymap.set("n", "<C-h>", function() M:open_selection_menu() end)
end

function M:add(index, key)
    if not index or index < 1 then
        error("index was nil or less than 1")
    end
    if not key or key == "" then
        error("key was nil or empty")
    end

    local entry_factory = require("harpun.entry_factory")
    local entry = self._list:get()[index]
    if entry then
        local entry_updating_prompt = require("harpun.entry_updating_prompt")
        entry_updating_prompt.prompt(self._list, index, entry_factory.create(key))
        return
    else
        entry = entry_factory.create(key)
        self._list:add_or_update(index, entry)
    end
end

function M:select(index)
    if not index or index < 1 then
        error("index was nil or less than 1")
    end

    local entry = self._list:get()[index]
    if not entry or entry.file_name == "" then
        print("Harpun: No file at index")
        return
    end

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

function M:open_selection_menu()
    require("harpun.entry_selection_menu"):open(self._list, self)
end

return M
