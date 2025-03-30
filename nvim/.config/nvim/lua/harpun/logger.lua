local M = {}

local function format(message)
    return string.format("%s - %s", "harpun", message)
end

function M.info(message)
    assert(message)
    Logger.info(format(message))
end

function M.warning(message)
    assert(message)
    Logger.warning(format(message))
end

function M.orror(message)
    assert(message)
    Logger.error(format(message))
end

return M
