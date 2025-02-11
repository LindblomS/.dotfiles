return {
    'stevearc/oil.nvim',
    commit = "add50252b5e9147c0a09d36480d418c7e2737472",
    opts = {
        buf_options = {
            bufhidden = true,
        },
        win_options = {
            wrap = true,
        },
        skip_confirm_for_simple_edits = true,
    },
    config = function()
        vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")
    end
}
