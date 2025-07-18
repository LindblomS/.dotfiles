vim.g.mapleader = ' '
vim.g.netrw_banner = 0

local o = vim.o
vim.opt.diffopt:append({ "algorithm:histogram" })
vim.o.winborder = "rounded"
o.nu = true
o.relativenumber = true
o.wrap = false

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.autoindent = true

o.swapfile = false
o.backup = false

o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.scrolloff = 8

o.cursorline = true
o.cursorlineopt = "number"
