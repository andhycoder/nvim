local set = vim.opt

set.number = true
set.numberwidth = 2
set.relativenumber = false
set.signcolumn = "yes"
set.cursorline = true

set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true

set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true

vim.schedule(function()
  set.clipboard = "unnamedplus"
end)

set.autoread = true
set.termguicolors = true
set.mouse = "a"
set.scrolloff = 4
set.splitbelow = true
set.splitright = true
set.splitkeep = "screen"
set.timeoutlen = 300
set.ttimeoutlen = 50
set.updatetime = 200
set.conceallevel = 2
set.concealcursor = ""
set.showmode = false
set.laststatus = 3

set.wrap = true
set.wrapscan = true
set.linebreak = true
set.breakindent = true
set.showbreak = "↳ "
set.list = true
set.listchars = {
  tab = "│ ",
  trail = "•",
  extends = "→",
  precedes = "←",
  nbsp = "◌",
}

set.lazyredraw = true
set.shada = "!,'100,<50,s10,h"
set.synmaxcol = 240
set.redrawtime = 1500
set.ttyfast = true
set.history = 5000

set.wildmenu = true
set.wildmode = "longest:full,full"
set.wildchar = string.byte("\t")

set.undofile = true
set.swapfile = false
set.backup = false

set.foldmethod = "indent"
set.foldlevel = 99

set.iskeyword:append("-")
