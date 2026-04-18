vim.pack.add({
    {
        src = "https://github.com/windwp/nvim-autopairs",
        version = "3d02855468f94bf435db41b661b58ec4f48a06b7",
    },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = "78336bc89ee5365633bcf754d93df01678b5c08f",
    },

})
require("nvim-autopairs").setup()
require("blink-cmp").setup(
    {
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
    }
)
