return {
    {
        "windwp/nvim-autopairs",
        commit = "3d02855468f94bf435db41b661b58ec4f48a06b7",
        event = "InsertEnter",
        enabled = true,
        config = true,
    },
    {
        'saghen/blink.cmp',
        commit = "ea29ab1620de5e61284abc01ae39e56df5a5fe53",
        enabled = true,
        opts = {
            keymap = {
                preset = 'default',
                ["<ESC>"] = { "cancel", "fallback" },
                ["<M-Up>"] = { "scroll_documentation_up" },
                ["<M-Down>"] = { "scroll_documentation_down" },
            },
            cmdline = {
                enabled = false,
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 250
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    }
                },
            },
            signature = { enabled = true },
            appearance = {
                nerd_font_variant = 'mono',
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "rust" }
        },
        opts_extend = { "sources.default" },
    },
}
