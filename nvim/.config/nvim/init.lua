vim.pack.add({
    {
        src = "https://github.com/kylechui/nvim-surround",
        version = "caf6f633d4d77a29b6e265b560c5a035d171a913",
    },
    {
        src = "https://github.com/nvim-tree/nvim-web-devicons",
        version = "4c3a5848ee0b09ecdea73adcd2a689190aeb728c",
    },
})

Logger = require("logger").setup({ minimum_log_level = vim.log.levels.INFO })

require("options")
require("vim_keymaps")
require("autocommands")
require("harpun"):setup()
require("file_exploring")
require("searching")
require("lsp")
require("sqlcmd")
require("completion")
require("nvim-surround").setup()
require("nvim-web-devicons").setup()

vim.diagnostic.config({
    virtual_text = true,
})

vim.o.bg = "light"
vim.cmd("colorscheme mycolorscheme")

-- Custom filetype for note taking
vim.filetype.add({
    extension = {
        notes = function()
            return "notes", function(buf)
                vim.bo[buf].textwidth = 100
            end
        end
    }
})
