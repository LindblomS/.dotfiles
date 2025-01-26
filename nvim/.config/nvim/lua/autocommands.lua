vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Set relative numbers to false for quick fix",
    callback = function()
        local ft = vim.o.filetype
        if ft == "qf" then
            vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
        end
    end
})


vim.api.nvim_create_autocmd("FileType", {
    desc = "Set commentstring depending on file type",
    callback = function()
        local ft = vim.o.filetype
        if ft == "cs" then
            vim.api.nvim_set_option_value("commentstring", "// %s", { scope = "local" })
        end
    end
})
