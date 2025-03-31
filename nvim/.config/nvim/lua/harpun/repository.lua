local Path = require("plenary.path")
local logger = require("harpun.logger")

local data_path = string.format("%s/harpun", vim.fn.stdpath("data"))
local data_path_exists = false

local function create_data_path()
    local path = Path:new(data_path)
    if not path:exists() then
        path:mkdir()
    end
    data_path_exists = true
end

local function get_data_path()
    if not data_path_exists then
        create_data_path()
    end
    return data_path
end

local function fullpath()
    local name = Git_branch() or ""

    -- Avoid branch name conflicts between different repositories.
    name = vim.fn.getcwd() .. name
    -- Hash the name to avoid special characters in the git branch name, e.g. dev/master.
    name = vim.fn.sha256(name)

    return string.format("%s/%s.json", get_data_path(), name)
end

local function write_data(data)
    Path:new(fullpath()):write(vim.json.encode(data), "w")
end

local function read_data()
    local path = Path:new(fullpath())

    if not path:exists() then
        write_data({})
    end

    local data = path:read()
    return vim.json.decode(data)
end

local M = {}

function M.new()
    local ok, data = pcall(read_data)
    if not ok then
        logger.error(data)
    end
    M._data = data
    M._err = not ok
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
