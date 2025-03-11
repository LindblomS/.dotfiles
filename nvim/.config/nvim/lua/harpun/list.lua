local M = {
    _list = {},
    _repository = {},
}
local logger = require("harpun.logger")

function M.new(repository)
    if not repository then
        logger.error("repository was nil")
    end

    M._repository = repository
    M._list = repository:get()
    return M
end

function M:add_or_update(index, entry)
    if not index or index < 1 then
        logger.error("index was nil or empty")
    end

    if not entry then
        logger.error("entry was nil")
    end

    local factory = require("harpun.entry_factory")

    -- Replace preceding nil entries will placeholders: lua will stop iteration on nil entries
    for i = 1, index - 1 do
        if not self._list[i] then
            self._list[i] = factory.create_placeholder()
        end
    end

    self._list[index] = entry
    self._repository:add_or_update(self._list)
end

function M:get()
    return self._list
end

return M
