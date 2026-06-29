vim.lsp.config.rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { "Cargo.toml" },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = false
                }
            }
        }
    },
}
vim.lsp.enable("rust_analyzer")

vim.api.nvim_create_autocmd('FileType', {
    pattern = { "rust" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "ia", "print@", "println!();<esc>T(i", {});
        vim.api.nvim_buf_set_keymap(0, "ia", "aaa@", "// arrange\n// act\n// assert", {});
    end,
})
