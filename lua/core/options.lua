local set = vim.opt

-- Ui
set.number = true
set.relativenumber = false
set.signcolumn = "yes"
set.cursorline = true
set.termguicolors = true
set.wrap = true
set.scrolloff = 4
set.sidescrolloff = 8
set.showbreak = "↳ "
set.list = true
set.listchars = {
  tab = "│ ",
  trail = "•",
  extends = "→",
  precedes = "←",
  nbsp = "◌",
}
set.linebreak = true
set.breakindent = true
set.conceallevel = 2
set.concealcursor = ""
set.showmode = false
set.laststatus = 3

-- Indentation
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true

-- Search
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true

-- Clipboard
vim.schedule(function()
  set.clipboard = "unnamedplus"
end)

-- Mouse
set.mouse = "a"

-- Splits
set.splitbelow = true
set.splitright = true
set.splitkeep = "screen"

-- Time
set.timeoutlen = 300
set.ttimeoutlen = 50
set.updatetime = 200

-- Performance
set.lazyredraw = true
set.shada = "!,'100,<50,s10,h"
set.synmaxcol = 240
set.redrawtime = 1500
set.ttyfast = true

-- Editor behavior
set.autoread = true
set.viewoptions:append { "slash", "unix" }
set.jumpoptions = "stack"
set.virtualedit:append("onemore")
set.wildmenu = true
set.wildmode = "longest:full,full"
set.wrapscan = true
set.wildchar = string.byte("\t")
set.shortmess:append { s = true, I = true, W = true, c = true, C = true }
set.showmatch = true

-- Undo / History
set.undofile = true
set.history = 5000

-- Backup
set.swapfile = false
set.backup = false

-- Folding
set.foldmethod = "indent"
set.foldlevel = 99

-- Misc
set.iskeyword:append("-")
set.isfname:append("@-@")
