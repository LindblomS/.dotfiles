local function get_selected_lines()
    local buf = 0
    local start_row = vim.fn.getpos("'<")[2] - 1 -- nvim_buf_get_lines is zero-indexed
    local end_row = vim.fn.getpos("'>")[2]
    local strict = false
    local lines = vim.api.nvim_buf_get_lines(buf, start_row, end_row, strict)
    return lines
end

vim.api.nvim_create_user_command("Sqlex", function()
    local sel_lines = get_selected_lines()
    local query = ""
    for _, line in pairs(sel_lines) do
        query = query .. " " .. line
    end

    local server = os.getenv("SQLCMD_SERVER")
    local database = os.getenv("SQLCMD_DATABASE")
    local output_file = "sqlcmd_output_file.txt"

    local cmd = string.format(
        "sqlcmd -y 30 -Y 30 -u -E -k -C -N -S \"%s\" -d %s -o %s -Q \"%s\"",
        server, database, output_file, query)

    vim.fn.system(cmd)

    local buf = vim.fn.bufnr(output_file)

    if buf == -1 then
        buf = vim.fn.bufadd(output_file)
    end

    if not vim.api.nvim_buf_is_loaded(buf) then
        vim.fn.bufload(buf)
        vim.api.nvim_set_option_value("buflisted", true, {
            buf = buf,
        })
    end

    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Runs the current visual selection as a query in sqlcmd" })
