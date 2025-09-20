return {
    "ibhagwan/fzf-lua",
    commit = "edf3524164c0878e64968cb1d4a24ba695b1ee12",
    opts = {
        keymap = {
            fzf = {
                ["ctrl-q"] = "select-all+accept",
            }
        },
        winopts = {
            preview = {
                hidden = true,
            }
        },
        lsp = {
            async_or_timeout = 20000,
        }
    },
    config = function(_, opts)
        local f = require("fzf-lua")
        f.setup(opts)
        local s = vim.keymap.set

        s("n", "<leader>ff", f.files, { desc = "[F]ind [f]iles" })
        s("n", "<leader>fb", f.buffers, { desc = "[F]ind [b]uffers" })
        s("n", "<leader>fw", f.live_grep, { desc = "[F]ind [w]ord" })
        s({ "n", "v" }, "<leader>fW", f.grep_cword, { desc = "[F]ind [w]ord under cursor or selection" })
        s("n", "<leader>faf", function()
            f.files({ no_ignore = true })
        end, { desc = "[F]ind [a]ll [f]iles" })
        s("n", "<leader>q", f.quickfix, { desc = "Quickfix list" })
        s("n", "<leader>j", f.jumps, { desc = "[J]umplist" })

        s("n", "gr", f.lsp_references, { desc = "Go to reference" })
        s("n", "gs", f.lsp_document_symbols, { desc = "Go to document symbol" })
        s("n", "gd", f.lsp_definitions, { desc = "Go to definition" })
        s("n", "gD", f.lsp_typedefs, { desc = "Go to type definition" })
        s("n", "gi", f.lsp_implementations, { desc = "Go to implementation" })
        s("n", "<leader>fld", f.lsp_document_diagnostics, { desc = "[F]ind [l]ocal [d]iagnostics" })
        s("n", "<leader>fgd", f.lsp_workspace_diagnostics, { desc = "[F]ind [g]lobal [d]iagnostics" })

        s("n", "<leader>fgwd",
            function() f.lsp_workspace_diagnostics({ severity_only = vim.diagnostic.WARN }) end,
            { desc = "[F]ind [g]lobal [w]arning [d]iagnostics" })

        s("n", "<leader>fged",
            function() f.lsp_workspace_diagnostics({ severity_only = vim.diagnostic.ERROR }) end,
            { desc = "[F]ind [g]lobal [e]rror [d]iagnostics" })

        s("n", "<leader>flwd",
            function() f.lsp_document_diagnostics({ severity_only = vim.diagnostic.severity.WARN }) end,
            { desc = "[F]ind [l]ocal [w]arning [d]iagnostics" })

        s("n", "<leader>fled",
            function() f.lsp_document_diagnostics({ severity_only = vim.diagnostic.severity.ERROR }) end,
            { desc = "[F]ind [l]ocal [e]rror [d]iagnostics" })

        vim.api.nvim_create_user_command("Helpt", function()
            f.helptags()
        end, { desc = "Search for help tags" })
    end
}
