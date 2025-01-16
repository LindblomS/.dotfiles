local M = {}

local function display_name(buf_name)
    local trimmed = false
    while #buf_name > 60 do
        buf_name = buf_name:sub(10)
        trimmed = true
    end
    if trimmed then
        buf_name = "..." .. buf_name
    end
    return buf_name
end

function M.create(buf_name, key)
    return {
        buf_name = buf_name,
        display_name = display_name(buf_name),
        key = key,
    }
end

return M
