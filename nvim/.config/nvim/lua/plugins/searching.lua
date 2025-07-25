return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
                commit = "3707cdb1e43f5cea73afb6037e6494e7ce847a66",
            },
        },
        commit = "415af52339215926d705cccc08145f3782c4d132",
        opts = {
            defaults = {
                -- Telescope needs to be updated with the new vim.o.winborder = "rounded" from nvim 0.11
                -- Setting border to false seems to be a nice temporary fix.
                border = false,
                layout_strategy = "vertical",
                layout_config = {
                    width = 0.9,
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim"
                },
                preview = true,
                path_display = {
                    "filename_first",
                    "truncate"
                },
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                    },
                    n = {
                        ["d"] = "delete_buffer",
                        ["a"] = "add_selection",
                        ["r"] = "remove_selection",
                        ["q"] = "send_selected_to_qflist",
                    },
                },
            },
        },
        keys = {
            { "<leader>ff" },
            { "<leader>fw" },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            local builtin = require("telescope.builtin")
            local set = vim.keymap.set
            set("n", "gr", builtin.lsp_references, { desc = "Go to reference" })
            set("n", "gs", builtin.lsp_document_symbols, { desc = "Go to document symbol" })
            set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
            set("n", "gD", builtin.lsp_type_definitions, { desc = "Go to type definition" })
            set("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
            set("n", "<leader>ff", builtin.find_files, { desc = "Find files, respects .gitignore" })
            set("n", "<leader>faf", function()
                builtin.find_files({ no_ignore = true })
            end, { desc = "Find all files" })
            set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            set("n", "<leader>fw", builtin.live_grep, { desc = "Find word" })
            set({ "n", "v" }, "<leader>fW", builtin.grep_string, { desc = "Find word under cursor or selection" })
            set("n", "<leader>q", builtin.quickfix, { desc = "Quickfix list" })
            set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [d]iagnostics" })
            set("n", "<leader>fld", function()
                builtin.diagnostics({ bufnr = 0 })
            end, {
                desc = "[F]ind [l]ocal [d]iagnostics (in current buffer)",
            })

            vim.api.nvim_create_user_command("Helpt", function()
                builtin.help_tags()
            end, { desc = "Search for help tags" })
        end,
    },
}
