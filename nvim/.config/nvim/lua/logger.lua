local M = {}

local _path = string.format("%s/custom_log.txt", vim.fn.stdpath("log"))
local _path_exists = false
local _print_log_entry = false

function M.new(options)
    _print_log_entry = options.print_log_entry
    return M
end

local function get_path()
    if not _path_exists then
        local file = io.open(_path, "a")
        if file then
            file:close()
            _path_exists = true
            return _path
        else
            -- File either didn't exist or we did not have permission

            -- Note that we don't have to check that the directory path exists.
            -- stdpath("log") is expected to exist.
            local new_file, err, code = io.open(_path, "a")
            if not new_file then
                vim.notify(string.format(
                        "Error creating custom log file. Error \"%s\", code \"%s\", filepath \"%s\"", err, code, _path),
                    vim.log.levels.ERROR)
                return nil
            else
                new_file:write()
                new_file:close()
            end
        end
    end
    return _path
end

local function write(log_entry)
    local path = get_path()
    if not path then
        return
    end
    local file = io.open(_path, "a")
    if file then
        file:write(log_entry)
        file:flush()
        file:close()
        if _print_log_entry then
            print(log_entry)
        end
    end
end

local function create_log_entry(message, level)
    message = string.format("%s - %s: %s\n", os.date(), level, message)
    return message
end

function M.info(message)
    write(create_log_entry(message, "info"))
end

function M.error(message)
    write(create_log_entry(message, "error"))
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

return M
