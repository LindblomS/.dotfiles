---@diagnostic disable: redefined-local

local _opts = {
    debug = false,
}

local function format_error(err, code)
    return string.format("Error: \"%s\". Exit code: %s", err, code)
end

local function log_debug(message)
    if _opts.debug then
        Logger.debug(message, true)
    end
end

local function write(file, content)
    assert(file)
    assert(content)

    local success, err, code = file:write(content)

    if not success then
        Logger.warning(string.format("Error writing to file. %s", format_error(err, code)), true)
        file:close()
        return false, err
    else
        log_debug("Write successful")
        file:flush()
        file:close()
        return true
    end
end

local function create_file(filename, mode)
    local directory_path = vim.fs.dirname(filename)
    local success, err, code = os.execute(string.format("mkdir -p %s", directory_path))
    if not success then
        Logger.warning(string.format("Error creating directory path. %s", format_error(err, code)), true)
        return nil, err
    end

    local file, err, code = io.open(filename, mode)
    if err then
        Logger.warning(string.format("Error creating file. %s", format_error(err, code)), true)
        return nil, err
    else
        -- File was successfully created
        return file
    end
end

local function inner_write(filename, mode, content)
    assert(filename)
    assert(content)

    if _opts.debug then
        log_debug(string.format("Writing to file: %s", filename))
    end

    local file = io.open(filename, mode)
    if not file then
        log_debug("File did not exist. Creating file...")

        local file, err = create_file(filename, mode)

        if err then
            return false, err
        end

        return write(file, content)
    end

    return write(file, content)
end

local M = {}

function M.setup(opts)
    _opts = vim.tbl_extend("force", _opts, opts)
    return M
end

function M.append(filename, content)
    assert(filename)
    assert(content)

    return inner_write(filename, "a", content)
end

function M.write(filename, content)
    assert(filename)
    assert(content)

    return inner_write(filename, "w", content)
end

function M.read(filename)
    assert(filename)

    local file, err, code = io.open(filename, "r")
    if not file then
        Logger.warning(string.format("Error reading file. %s", format_error(err, code)))
        return nil, err
    else
        local content = file:read("a")
        file:close()
        return content
    end
end

return M
