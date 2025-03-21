local list = {}
list.new = function(repository)
    if not repository then
        error("repository was nil")
    end
    list._repository = repository
    list._list = repository:get()
    return list
end

list.add = function(self, entry)
    if not self then
        error("self was nil")
    end
    if not entry then
        error("entry was nil")
    end
    table.insert(self._list, entry)
    self._repository:add_or_update(self._list)
end

list.remove = function(self, index)
    if not self then
        error("self was nil")
    end
    table.remove(self._list, index)
    self._repository:add_or_update(self._list)
end

-- list.move = function(self, index, new_index)
--     error("not implemented")
-- end

list.get = function(self)
    return self._list
end

local M = {}
M.setup = function()
    local repository = require("harpun.repository").new()
    M._list = list.new(repository)
    M._entry_factory = require("harpun.entry_factory")

    vim.keymap.set("n", "<leader>h", function() M:add() end)
    vim.keymap.set("n", "<C-h>", function() M:open_selection_menu() end)
end

M.add = function(self)
    local entry = self._entry_factory.create()
    self._list:add(entry)
end

M.open_selection_menu = function(self)
    require("harpun.entry_selection_menu"):open(self._list)
end

return M
