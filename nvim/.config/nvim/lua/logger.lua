local _fs = require("fs")
local _path = string.format("%s/custom_log.txt", vim.fn.stdpath("log"))
local _error_logging_to_file = false

local _opts = {
    minimum_log_level = vim.log.levels.INFO,
}

local log_levels = {
    [vim.log.levels.DEBUG] = "debug",
    [vim.log.levels.ERROR] = "error",
    [vim.log.levels.WARN] = "warning",
    [vim.log.levels.INFO] = "info",
}

local function write(log_entry, only_print)
    assert(log_entry)

    if only_print then
        print(log_entry)
        return
    end

    -- We can't log to file
    if _error_logging_to_file then
        return
    end

    local _, err = _fs.append(_path, log_entry)

    if err then
        print(string.format("Error writing logs. %s", err))
        _error_logging_to_file = true
        return
    end
end

local function create_log_entry(message, log_level)
    message = string.format("%s - %s: %s\n", os.date(), log_levels[log_level], message)
    return message
end

vim.api.nvim_create_user_command("CustomLog", function()
    local buf = vim.fn.bufadd(_path)
    vim.fn.bufload(buf)
    vim.api.nvim_set_option_value("buflisted", true, { buf = buf, })
    vim.api.nvim_set_option_value("readonly", true, { buf = buf })
    vim.api.nvim_set_current_buf(buf)

    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = buf,
        callback = function(ev)
            vim.api.nvim_buf_delete(ev.buf, { force = true })
        end,
        desc = "Delete buffer when leaving it",
    })
end, { desc = "Open the custom logs in the current window" })

local function log(message, log_level, only_print)
    if log_level >= _opts.minimum_log_level then
        write(create_log_entry(message, log_level), only_print)
    end
end

local M = {}

function M.setup(opts)
    _opts = vim.tbl_extend("force", _opts, opts)
    return M
end

function M.debug(message, only_print)
    log(message, vim.log.levels.DEBUG, only_print)
end

function M.info(message, only_print)
    log(message, vim.log.levels.INFO, only_print)
end

function M.warning(message, only_print)
    log(message, vim.log.levels.WARN, only_print)
end

function M.error(message, only_print)
    log(message, vim.log.levels.ERROR, only_print)
end

return M
