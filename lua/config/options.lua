-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local o = vim.o

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2

o.swapfile = false

o.scrolloff = 8
o.sidescrolloff = 8

o.smartindent = true
o.hlsearch = true
o.autoindent = true
o.expandtab = true
o.inccommand = "split"
o.ignorecase = true
o.smarttab = true
o.breakindent = true
o.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }

o.backup = false

vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_nodules/*" })
vim.opt.formatoptions:append({ "r" })

o.mouse = "a"

-- o.foldcolumn = "1" -- '0' is not bad
-- o.foldlevel = 99
-- o.foldlevelstart = 99
-- o.foldenable = true
