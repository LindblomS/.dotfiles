local Path = require("plenary.path")
local data_path = string.format("%s/harpun", vim.fn.stdpath("data"))
local ensured_data_path = false
local function ensure_data_path()
    if ensured_data_path then
        return
    end

    local path = Path:new(data_path)
    if not path:exists() then
        path:mkdir()
    end

    ensured_data_path = true
end

local function fullpath()
    return string.format("%s/%s.json", data_path, Git_branch())
end

local function write_data(data)
    Path:new(fullpath()):write(vim.json.encode(data), "w")
end

local function read_data()
    ensure_data_path()
    local path = Path:new(fullpath())

    if not path:exists() then
        write_data({})
    end

    local data = path:read()

    -- Why is this necessary when we write the data just before
    -- if the file doesn't exist?
    -- if not data or data == "" then
    --     write_data({})
    --     data = {}
    -- end

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
        error("Harpun: Error reading the data file, cannot read data: %s")
    end

    return self._entries
end

function M:add_or_update(entries)
    if self._err then
        error("Harpun: Error reading the data file, cannot write data")
    end

    write_data(self._entries)
end

return M
