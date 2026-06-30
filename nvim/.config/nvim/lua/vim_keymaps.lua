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

local function substitute_word(opts)
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

    local pattern
    if opts.use_word_boundary then
        pattern = string.format("\\<%s\\>", word)
    else
        pattern = word
    end

    local range
    if opts.use_visual_range then
        range = "'<,'>"
    else
        range = "%"
    end

    vim.api.nvim_feedkeys(string.format(":%ss/%s/%s", range, pattern, word), "n", false)
end

keymap.set({ "n", "v" }, "<leader>s", function() substitute_word({}) end,
    { desc = "Substitute word under cursor or visual selection" })

keymap.set({ "n", "v" }, "<leader>S", function() substitute_word({ use_word_boundary = true }) end,
    { desc = "Substitute word under cursor or visual selection using word bounderies" })

keymap.set({ "n", "v" }, "<leader>vs", function() substitute_word({ use_visual_range = true }) end,
    { desc = "In the last visual selection, substitute word under cursor or visual selection" })

keymap.set({ "n", "v" }, "<leader>vS",
    function() substitute_word({ use_word_boundary = true, use_visual_range = true }) end,
    { desc = "In the last visual selection, substitute word under cursor or visual selection using word bounderies" })

keymap.set("t", "<M-t>", "<C-\\><C-N>", { desc = "Exit terminal mode" })
