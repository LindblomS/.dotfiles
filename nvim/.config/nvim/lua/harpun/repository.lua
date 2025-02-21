local Path = require("plenary.path")

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
    return string.format("%s/%s.json", get_data_path(), Git_branch_or_cwd())
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

local M = {
    _entries = {},
    _err = false,
}

function M.new()
    local ok, data = pcall(read_data)
    M._entries = data
    M._err = not ok
    return M
end

function M:get()
    if self._err then
        print("Harpun: Error reading the data file, cannot read data")
        return {}
    end

    return self._entries
end

function M:add_or_update(entries)
    if self._err then
        print("Harpun: Error reading the data file, cannot write data")
        return
    end

    self._entries = entries
    write_data(self._entries)
end

return M
