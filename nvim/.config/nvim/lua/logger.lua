local M = {}

local _path = string.format("%s/custom_log.txt", vim.fn.stdpath("log"))
local _path_exists = false
local _display_log_message = true

local function get_path()
    if not _path_exists then
        local path = require("plenary.path"):new(_path)
        if not path:exists() then
            path:touch()
        end
        _path_exists = true
    end
    return _path
end

local function write(log_entry)
    local path = get_path()
    local ok, file_or_err = pcall(io.open, path, "w")
    if not ok then
        print(file_or_err)
    end
    local file = file_or_err
    -- Since there wasn't an error, we know file won't be nil. But lua_ls doesn't know this.
    if file then
        file:write(log_entry)
        file:flush()
        file:close()
        if _display_log_message then
            print(log_entry)
        end
    end
end

local function create_log_entry(message, level)
    message = string.format("%s - %s: %s", os.date(), level, message)
    return message
end

function M.info(message)
    write(create_log_entry(message, "info"))
end

function M.error(message)
    write(create_log_entry(message, "error"))
end

return M
