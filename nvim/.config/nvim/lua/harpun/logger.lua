local M = {}

function M.error(message)
    Logger.info(string.format("%s - %s", "harpun", message))
end

return M
