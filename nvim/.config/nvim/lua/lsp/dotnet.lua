-- Helper command for testing in dotnet that will open a terminal with the "dotnet test" command with:
-- - The first project found by traversing upward using the current filepath.
--   This argument will be left out if no project is found and will stop searching on cwd.
--
-- - Filter on word under cursor, if any.
--
-- Example
-- dotnet test Lib.Test.csproj --filter="Do"
vim.api.nvim_create_user_command("DotnetTest",
    function()
        local function find_csproj()
            -- Stop searching when reaching this directory
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

        local word = vim.F.if_nil(nil, vim.fn.expand("<cword>"))
        if word then
            table.insert(cmd_params, string.format("--filter=\"%s\"", word))
        end

        local cmd = "dotnet test"
        for _, p in pairs(cmd_params) do
            cmd = cmd .. " " .. p
        end

        vim.cmd(":term")
        local channel = vim.bo.channel
        vim.api.nvim_chan_send(channel, cmd)
    end, {
        desc = "dotnet test [current test project] [--filter={word under cursor}]"
    }
)

vim.api.nvim_create_user_command('Dotnet',
    function()
        require("roslyn").setup({
            filewatching = false,
            config = {
                ["csharp|completion"] = {
                    dotnet_provide_regex_completions = false,
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                    dotnet_show_name_completion_suggestions = false,
                },
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = false,
                    dotnet_enable_tests_code_lens = false,
                },
                ["csharp|background_analysis"] = {
                    -- change to openFiles if performance is slow
                    dotnet_analyzer_diagnostics_scope = "fullSolution",
                    dotnet_compiler_diagnostics_scope = "fullSolution"
                }
            },
        })
    end,
    {}
)
