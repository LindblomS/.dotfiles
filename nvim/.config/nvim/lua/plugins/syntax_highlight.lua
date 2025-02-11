return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        commit = "6108ba7a135ed37e32276ccb877a348af17fe411",
        config = function()
            local configs = require('nvim-treesitter.configs')
            configs.setup({
                ensure_installed = { 'lua', 'rust', 'c_sharp', 'vim', 'toml', 'typescript', 'javascript', 'vue', "html", "css", "json", "bash" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
}
