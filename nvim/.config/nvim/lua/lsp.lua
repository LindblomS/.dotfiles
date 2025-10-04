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

Global_var_term_buf = "global_var_term_buf"

-- todo:
-- Add keymap <leader>t to open terminal if it exists
-- Setup_test_cmd for rust

-- Setup the Test command which will utilize a reuseable terminal for running test command, e.g. `dotnet test --filter="..."`.
function Setup_test_cmd(get_cmd)
    vim.api.nvim_create_user_command("Test", function()
        local function execute_cmd(buf, cmd)
            vim.api.nvim_set_current_buf(buf)
            local chan = vim.bo[buf].channel
            vim.api.nvim_chan_send(chan, cmd)
        end

        -- todo: comment about current buffer and getting word under cursor
        local cmd = get_cmd()

        -- Reuse terminal if it already exists.
        local ok, buf = pcall(vim.api.nvim_get_var, Global_var_term_buf)
        if ok and buf then
            execute_cmd(buf, cmd)
            return
        end

        vim.cmd(":term")
        -- Terminal needs time to initialize before running vim.api.nvim_chan_send.
        os.execute("sleep " .. tonumber(0.1))

        buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_set_var(Global_var_term_buf, buf)
        execute_cmd(buf, cmd)

        -- Reset Global_var_term_buf when this buffer is deleted.
        vim.api.nvim_create_autocmd("BufDelete", {
            buffer = buf,
            callback = function()
                vim.api.nvim_set_var(Global_var_term_buf, nil)
            end
        })
    end, {})
end
