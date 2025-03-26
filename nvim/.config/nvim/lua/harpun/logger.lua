local M = {}

local function format(message)
    return string.format("%s - %s", "harpun", message)
end

M.info = function(message)
    Logger.info(format(message))
end

M.error = function(message)
    Logger.error(format(message))
end

return M
