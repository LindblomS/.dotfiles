vim.opt.termguicolors = true
require("options")
require("vim_keymaps")
require("autocommands")
-- vim.cmd("language en_US")
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    change_detection = {
        enabled = true,
        notify = false,
    }
})

require("harpun").setup()
require("statusline")
require("oil").setup()
