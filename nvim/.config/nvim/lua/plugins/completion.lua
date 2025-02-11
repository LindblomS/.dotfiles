return {
    {
        "hrsh7th/nvim-cmp",
        commit = "12509903a5723a876abd65953109f926f4634c30",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp", commit = "99290b3ec1322070bcfb9e846450a46f6efa50f0", },
            { "hrsh7th/cmp-buffer",   commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa", },
            { "hrsh7th/cmp-path",     commit = "91ff86cd9c29299a64f968ebb45846c485725f23", }
        },
        opts = function()
            local cmp = require("cmp")
            return {
                window = {
                    completion = cmp.config.window.bordered()
                },
                mapping = cmp.mapping.preset.insert({
                    ["<esc>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-j>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            }
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            local servers = { "lua_ls", "volar", "html" }
            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    capabilities = capabilities
                })
            end
        end,
    },
    {
        "windwp/nvim-autopairs",
        commit = "3d02855468f94bf435db41b661b58ec4f48a06b7",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function(_, _)
            require("nvim-autopairs").setup({})
            local autopairs_cmp = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on(
                "confirm_done",
                autopairs_cmp.on_confirm_done()
            )
        end
    }
}
