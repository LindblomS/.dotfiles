local logger = require("harpun.logger")

local data_path = string.format("%s/harpun", vim.fn.stdpath("data"))
local _fs = require("fs")

local function fullpath()
    local name = Git_branch() or ""

    -- Avoid branch name conflicts between different repositories.
    name = vim.fn.getcwd() .. name
    -- Hash the name to avoid special characters in the git branch name, e.g. dev/master.
    name = vim.fn.sha256(name)

    return string.format("%s/%s.json", data_path, name)
end

local function write_data(data)
    _fs.write(fullpath(), vim.json.encode(data))
end

local function read_data()
    local data, err = _fs.read(fullpath())
    if data then
        return vim.json.decode(data)
    else
        return nil, err
    end
end

local M = {}

function M.new()
    local data, err = read_data()
    if not data then
        logger.error(err)
    end
    M._data = data
    M._err = err
    return M
end

function M:get()
    if self._err then
        return {}
    end

    return self._data
end

function M:add_or_update(data)
    if self._err then
        return
    end

    self._data = data
    write_data(self._data)
end

return M
