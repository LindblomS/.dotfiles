local function choose_solution(solutions)
    if #solutions == 0 then
        return nil
    end

    local names = {}
    for i, v in ipairs(solutions) do
        names[i] = vim.fs.basename(v)
    end

    local selected_index
    vim.ui.select(names, { prompt = "Select solution" },
        function(_, index)
            selected_index = index
        end)

    if not selected_index then
        return nil
    end

    return solutions[selected_index]
end

local function get_solution(buffer)
    local directory = vim.fs.root(buffer, function(name)
        -- .gitignore is expected to always exist.
        return name:match(".gitignore") ~= nil
    end)

    if not directory then
        vim.notify("No root directory for finding dotnet solution", vim.log.levels.INFO)
        return nil
    end

    local tmp_filename = "fd_dotnet_sln_temp"

    local cmd = string.format("fd --type f --extension slnx --extension sln --absolute-path > %s", tmp_filename)
    local ok, _, _ = os.execute(cmd)

    if not ok then
        vim.notify("Error finding dotnet solution", vim.log.levels.WARN)
    end

    local solutions = {}
    for l in io.lines(tmp_filename) do
        table.insert(solutions, l)
    end

    vim.fs.rm(tmp_filename)

    return choose_solution(solutions)
end

local solution = nil
local augroup = vim.api.nvim_create_augroup("Roslyn", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = augroup,
    pattern = "*.cs",
    callback = function(opt)
        solution = get_solution(opt.buf)

        -- The solution picker won't show up anymore after deleting the autocommand group.
        vim.api.nvim_del_augroup_by_id(augroup)

        if solution then
            vim.lsp.enable("roslyn")
        end
    end,
})

-- Setup a helper command for testing in dotnet that will open a terminal with the "dotnet test" command with:
-- - The first project found by traversing upward using the current filepath.
--   This argument will be left out if no project is found and will stop searching on cwd.
--
-- - Filter on word under cursor, if any.
--
-- Example
-- dotnet test Lib.Test.csproj --filter="Do"
local function setup_test_cmd()
    Setup_test_cmd(function()
        -- Find the first project by traversing upward using the current filepath.
        local function find_csproj()
            -- Stop searching when reaching this directory
            -- Note that stop_path itself will no be searched.
            local stop_path = vim.fn.getcwd()
            -- Start searching from the current file
            local start_path = vim.api.nvim_buf_get_name(0)

            local matches = vim.fs.find(function(name, _)
                return string.match(name, "%.csproj$")
            end, {
                path = start_path,
                stop = stop_path,
                upward = true,
            })
            return matches[1]
        end

        local cmd_params = {}

        local csproj = find_csproj()
        if csproj then
            table.insert(cmd_params, csproj)
        end

        -- Get word under cursor
        local word = vim.F.if_nil(nil, vim.fn.expand("<cword>"))
        if word ~= "" then
            table.insert(cmd_params, string.format("--filter=\"%s\"", word))
        end

        table.insert(cmd_params,
            "-p:RunAnalyzers=false -p:EnableNETAnalyzers=false -p:AnalysisMode=None -p:WarningLevel=0")

        -- Sometimes it's necessary to exclude this param. Inserting it last
        -- makes it easier to remove.
        table.insert(cmd_params, "--no-restore")

        local cmd = "dotnet test"
        for _, p in pairs(cmd_params) do
            cmd = cmd .. " " .. p
        end

        return cmd
    end)
end

vim.lsp.config("roslyn", {
    filetypes = { "cs" },
    cmd = {
        "roslyn-language-server",
        "--logLevel",
        "Information",
        "--stdio",
    },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
    on_init = {
        function(client, _)
            vim.notify("Initializing Roslyn for: " .. solution, vim.log.levels.INFO)

            client:notify("solution/open", {
                solution = vim.uri_from_fname(solution),
            })

            setup_test_cmd()
        end
    },
    on_exit = {
        function()
            vim.schedule(function()
                vim.notify("Roslyn stopped", vim.log.levels.INFO)
            end)
        end
    },
    settings = {
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = false,
            dotnet_enable_tests_code_lens = false
        },
        ["csharp|completion"] = {
            dotnet_provide_regex_completions = false,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = false,
        },
        ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true
        },
        ["csharp|projects"] = {
            dotnet_enable_automatic_restore = false,
        }
    },
    handlers = {
        ["workspace/projectInitializationComplete"] = function(_, _, _)
            vim.notify("Roslyn initialization complete", vim.log.levels.INFO)
            vim.lsp.diagnostic._refresh()
        end,
    },
    commands = require("lsp.roslyn.commands")
})


vim.api.nvim_create_autocmd('FileType', {
    pattern = { "cs" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "ia", "print@", "Console.WriteLine();<esc>T(i", {});
    end,
})
