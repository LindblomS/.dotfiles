local M = {}

function M.setup(self)
    M._list = require("harpun.list").new()
    M._util = require("harpun.util")
    M._selection_menu = require("harpun.selection_menu"):new(self)
    M._logger = require("harpun.logger")

    vim.keymap.set("n", "<leader>h", function() M:add() end)
    vim.keymap.set("n", "<C-h>", function() M:open_selection_menu() end)
end

function M.add(self)
    local file = self._util.get_file()
    self._logger.info(string.format("Adding file \"%s\"", file))
    self._list:add(self._util.get_file())
end

function M.get(self)
    return self._list:get()
end

function M.select(self, file)
    assert(file)
    self._logger.info(string.format("selecting file \"%s\"", file))

    local buf = vim.fn.bufnr(file)

    if buf == -1 then
        self._logger.info("Adding buffer")
        buf = vim.fn.bufadd(file)
    end

    if not vim.api.nvim_buf_is_loaded(buf) then
        self._logger.info("Load buffer")
        vim.fn.bufload(buf)
        vim.api.nvim_set_option_value("buflisted", true, {
            buf = buf,
        })
    end
    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_feedkeys("zz", "n", false)
end

function M.move(self, index, new_index)
    assert(index > 0)
    assert(new_index)
    self._list:move(index, new_index)
end

function M.remove(self, index)
    self._list:remove(index)
end

function M.save(self)
    self._logger.info("saving files")
    self._list:save()
end

function M.open_selection_menu(self)
    self._selection_menu:open()
end

return M
