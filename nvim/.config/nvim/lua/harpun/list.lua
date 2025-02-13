local M = {
    _inner_list = {},
    _repository = {},
}

function M.new(repository)
    if not repository then
        error("repository was nil")
    end

    M._repository = repository
    M._inner_list = repository:get()
    return M
end

function M:add_or_update(index, entry)
    if not index or index < 1 then
        error("index was nil or empty")
    end

    if not entry then
        error("entry was nil")
    end

    self._inner_list[index] = entry
    self._repository:add_or_update(index, entry)
end

function M:get()
    return self._inner_list
end

return M
