vim.opt.termguicolors = true
require("options")
require("vim_keymaps")
require("autocommands")

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    change_detection = {
        enabled = true,
        notify = false,
    }
})

function Git_branch()
    local b = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if b == "" then
        return "none"
    else
        return b
    end
end

require("harpun").setup()
require("statusline")
require("oil").setup()
