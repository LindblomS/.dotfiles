local M = {}

function M.error(message)
    Logger.error(string.format("%s - %s", "harpun", message))
end

return M
