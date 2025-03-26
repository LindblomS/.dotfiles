-- todo: rewrite M.arst = function to function M.arst(...) for all places
local logger = require("harpun.logger")
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
    if not entry then
        error("entry was nil")
    end
    table.insert(self._list, entry)
    -- self._repository:add_or_update(self._list)
end

list.remove = function(self, index)
    table.remove(self._list, index)
    -- self._repository:add_or_update(self._list)
end

list.move = function(self, index, new_index)
    if index < 1 then
        error("index was less than 1")
    end

    -- Out of bounds
    if new_index < 1 then
        return
    end
    if new_index > #self._list then
        return
    end

    local entry = table.remove(self._list, index)
    if not entry then
        -- todo: Maybe this should be a warn since it shouldn't happen.
        logger.info("Could not move entry. Entry was nil")
        return
    end
    table.insert(self._list, new_index, entry)
end

list.save = function(self)
    self._repository:add_or_update(self._list)
end

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
    require("harpun.entry_selection_menu"):new(self._list):open()
end

return M
