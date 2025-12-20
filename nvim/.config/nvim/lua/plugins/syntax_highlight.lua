return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        commit = "f22181a62c47bf591fbfd6ada7d9a1156278d6e0",
        config = function()
            local configs = require('nvim-treesitter.configs')
            configs.setup({
                ensure_installed = { 'lua', 'rust', 'c_sharp', 'vim', 'toml', 'typescript', 'javascript', 'vue', "html", "css", "json", "bash" },
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            })
        end
    },
}
