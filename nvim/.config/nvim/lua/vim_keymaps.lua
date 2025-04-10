local keymap = vim.keymap
keymap.set("n", "<leader>m", "<cmd>messages<cr>")
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('x', '<leader>p', '\"_dP"')
keymap.set('n', '<leader>y', '\"+y')
keymap.set('v', '<leader>y', '\"+y')
keymap.set('n', '<ESC>', ':noh <CR>', { silent = true })
keymap.set('n', '<C-y>', '<C-y><C-y><C-y>')
keymap.set('n', '<C-e>', '<C-e><C-e><C-e>')
keymap.set({ "n", "v" }, "<leader>s", function()
    local word
    local visual = vim.fn.mode() == "v"
    if visual then
        local saved_reg = vim.fn.getreg("v")
        vim.cmd [[noautocmd sil norm! "vy]]
        local selection = vim.fn.getreg("v")
        vim.fn.setreg("v", saved_reg)
        word = vim.F.if_nil(nil, selection) -- vim.F is deprecated. Use something else.
    else
        word = vim.F.if_nil(nil, vim.fn.expand("<cword>"))
    end
    vim.api.nvim_feedkeys(string.format(":%%s/%s/", word), "n", false)
end, { desc = "Substitute word under cursor or selection" })
keymap.set("n", "q", "<Nop>",
    { desc = "I never use complex repeats so it's more convenient to just disable it. Se :h q" })
