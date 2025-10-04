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

-- Setup a helper command for testing in dotnet that will open a terminal with the "dotnet test" command with:
-- - The first project found by traversing upward using the current filepath.
--   This argument will be left out if no project is found and will stop searching on cwd.
--
-- - Filter on word under cursor, if any.
--
-- Example
-- dotnet test Lib.Test.csproj --filter="Do"
local test_cmd_initialized = false
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*.cs",
    callback = function()
        -- The Test command does not need to be initialized per buffer that the lsp attaches to. Could maybe make this cleaner with a different design.
        if test_cmd_initialized then
            return
        end

        Setup_test_cmd(function()
            -- Find the first project by traversing upward using the current filepath.
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

            -- Get word under cursor
            local word = vim.F.if_nil(nil, vim.fn.expand("<cword>"))
            if word ~= "" then
                table.insert(cmd_params, string.format("--filter=\"%s\"", word))
            end

            local cmd = "dotnet test"
            for _, p in pairs(cmd_params) do
                cmd = cmd .. " " .. p
            end

            return cmd
        end)

        test_cmd_initialized = true
    end
})
