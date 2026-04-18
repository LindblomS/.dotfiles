vim.pack.add({
    {
    src = "https://github.com/ibhagwan/fzf-lua",
    -- name = "fzf",
    version = "edf3524164c0878e64968cb1d4a24ba695b1ee12",
}
})

local fzf = require("fzf-lua")
fzf.setup({
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
    },
    fzf_colors = {
        true, -- inherit fzf colors that aren't specified below from
        -- the auto-generated theme similar to `fzf_colors=true`
        ["fg"]      = { "fg", "Normal" },
        ["bg"]      = { "bg", "Normal" },
        ["hl"]      = { "fg", "Normal" },
        ["fg+"]     = { "fg", "Normal" },
        ["bg+"]     = { "bg", "Visual" },
        ["hl+"]     = { "fg", "Normal" },
        ["info"]    = { "fg", "Normal" },
        ["prompt"]  = { "fg", "Normal" },
        ["pointer"] = { "fg", "Normal" },
        ["marker"]  = { "fg", "Normal" },
        ["spinner"] = { "fg", "Normal" },
        ["header"]  = { "fg", "Normal" },
        ["query"]   = { "fg", "Normal" },
        ["gutter"]  = "-1",
    },
})

local s = vim.keymap.set

s("n", "<leader>ff", fzf.files, { desc = "[F]ind [f]iles" })
s("n", "<leader>fb", fzf.buffers, { desc = "[F]ind [b]uffers" })
s("n", "<leader>fw", fzf.live_grep, { desc = "[F]ind [w]ord" })
s({ "n", "v" }, "<leader>fW", fzf.grep_cword, { desc = "[F]ind [w]ord under cursor or selection" })
s("n", "<leader>faf", function()
    fzf.files({ no_ignore = true })
end, { desc = "[F]ind [a]ll [f]iles" })
s("n", "<leader>q", fzf.quickfix, { desc = "Quickfix list" })
s("n", "<leader>j", fzf.jumps, { desc = "[J]umplist" })

s("n", "gr", fzf.lsp_references, { desc = "Go to reference" })
s("n", "gs", fzf.lsp_document_symbols, { desc = "Go to document symbol" })
s("n", "gd", fzf.lsp_definitions, { desc = "Go to definition" })
s("n", "gD", fzf.lsp_typedefs, { desc = "Go to type definition" })
s("n", "gi", fzf.lsp_implementations, { desc = "Go to implementation" })
s("n", "<leader>fld", fzf.lsp_document_diagnostics, { desc = "[F]ind [l]ocal [d]iagnostics" })
s("n", "<leader>fgd", fzf.lsp_workspace_diagnostics, { desc = "[F]ind [g]lobal [d]iagnostics" })

s("n", "<leader>fgwd",
    function() fzf.lsp_workspace_diagnostics({ severity_only = vim.diagnostic.WARN }) end,
    { desc = "[F]ind [g]lobal [w]arning [d]iagnostics" })

s("n", "<leader>fged",
    function() fzf.lsp_workspace_diagnostics({ severity_only = vim.diagnostic.ERROR }) end,
    { desc = "[F]ind [g]lobal [e]rror [d]iagnostics" })

s("n", "<leader>flwd",
    function() fzf.lsp_document_diagnostics({ severity_only = vim.diagnostic.severity.WARN }) end,
    { desc = "[F]ind [l]ocal [w]arning [d]iagnostics" })

s("n", "<leader>fled",
    function() fzf.lsp_document_diagnostics({ severity_only = vim.diagnostic.severity.ERROR }) end,
    { desc = "[F]ind [l]ocal [e]rror [d]iagnostics" })

vim.api.nvim_create_user_command("Help", function()
    fzf.helptags()
end, { desc = "Search for help tags" })
