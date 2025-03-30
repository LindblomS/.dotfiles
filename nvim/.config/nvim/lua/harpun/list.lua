local M = {}

function M.new()
    local repository = require("harpun.repository").new()
    M._repository = repository
    M._list = repository:get()
    M._logger = require("harpun.logger")
    return M
end

function M.add(self, file)
    assert(file)
    table.insert(self._list, file)
end

function M.remove(self, index)
    assert(index)
    table.remove(self._list, index)
end

function M.move(self, index, new_index)
    assert(index > 0)
    assert(new_index)

    -- When out of bounds, do nothing and just return.
    if new_index < 1 then
        return
    end
    if new_index > #self._list then
        return
    end

    local file = table.remove(self._list, index)
    if not file then
        self._logger.warning("Could not move file. File was nil")
        return
    end
    table.insert(self._list, new_index, file)
end

function M.save(self)
    self._repository:add_or_update(self._list)
end

function M.get(self)
    return self._list
end

return M
