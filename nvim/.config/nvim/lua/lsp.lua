vim.lsp.config.jsonls = require("lsp.jsonls")
vim.lsp.enable("jsonls")

vim.lsp.config.html = require("lsp.html")
vim.lsp.enable("html")

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

vim.lsp.config.lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' }
            }
        }
    },
}
vim.lsp.enable("lua_ls")

vim.lsp.config.ts_ls = require("lsp.ts_ls")
vim.lsp.enable("ts_ls")

vim.lsp.config.eslint = require("lsp.eslint")
vim.lsp.enable("eslint")

require("lsp.dotnet")

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local lsp_opts = { buffer = args.buf }
        vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, lsp_opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, lsp_opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, lsp_opts)
        vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format() end, lsp_opts)

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = { '*.{cs,rs,lua}' },
            callback = function()
                vim.lsp.buf.format()

                -- Hack to keep diagnostics after format in lua_ls.
                if client.name == "lua_ls" then
                    vim.diagnostic.enable()
                end
            end
        })
    end
})
