vim.pack.add({
    {
        src = "https://github.com/seblyng/roslyn.nvim",
        version = "b62d1a588765f0aa1b46ed260252c9e456408835",
    },
})

local roslyn = require("roslyn")

roslyn.setup()

vim.lsp.config("roslyn", {
    cmd = {
        "roslyn-language-server",
        "--logLevel",              -- this property is required by the server
        "Information",
        "--extensionLogDirectory", -- this property is required by the server
        vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls/logs"),
        "--stdio",
    },
    settings = {
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution",
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
        }
    }
})

vim.lsp.enable("roslyn")
