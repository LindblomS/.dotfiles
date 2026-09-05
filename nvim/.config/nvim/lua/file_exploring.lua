vim.pack.add({
    {
        src = "https://github.com/stevearc/oil.nvim",
        version = "b73018b75affd13fa38e2fc94ef753b465f770d7",
    }
})

require("oil").setup({
    buf_options = {
        bufhidden = "hide",
    },
    win_options = {
        wrap = true,
    },
    view_options = {
        show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,

})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")
