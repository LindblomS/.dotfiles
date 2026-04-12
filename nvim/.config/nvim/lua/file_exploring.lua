vim.pack.add({
    {
        src = "https://github.com/stevearc/oil.nvim",
        version = "add50252b5e9147c0a09d36480d418c7e2737472",
    }
})

-- todo: check if we want these settings
-- watch_for_changes = true,
-- view_options = {
--  show_hidden = true,
--}

require("oil").setup({
    buf_options = {
        bufhidden = "hide",
    },
    win_options = {
        wrap = true,
    },
    skip_confirm_for_simple_edits = true,

})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")
