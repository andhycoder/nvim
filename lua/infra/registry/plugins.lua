local M = {}

M.phase1 = {
  { source = "folke/tokyonight.nvim", name = "tokyonight" },
  { source = "echasnovski/mini.nvim" },
  { source = "MeanderingProgrammer/render-markdown.nvim" },
  { source = "stevearc/oil.nvim" },
  { source = "refractalize/oil-git-status.nvim" },
  { source = "nvim-treesitter/nvim-treesitter" },
  { source = "rafamadriz/friendly-snippets" },
  { source = "saghen/blink.lib" },
  { source = "saghen/blink.cmp" },
}

M.phase2 = {
  { source = "neovim/nvim-lspconfig" },
  { source = "stevearc/conform.nvim" },
  { source = "mfussenegger/nvim-dap" },
  { source = "nvim-neotest/nvim-nio" },
  { source = "rcarriga/nvim-dap-ui" },
}

M.phase3 = {}

return M
