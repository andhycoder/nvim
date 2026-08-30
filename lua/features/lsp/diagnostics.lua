local M = {}

-- ============================================================================
-- LSP Diagnostics
-- ============================================================================

function M.setup_diagnostics()
  vim.diagnostic.config {
    virtual_text = false,
    severity_sort = true,
    underline = true,
    update_in_insert = false,

    float = {
      border = "rounded",
      source = "if_many",
      header = "",
      prefix = "",
      focusable = true,
    },

    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
    },
  }
end

-- ============================================================================
-- Setup
-- ============================================================================

function M.setup()
  M.setup_diagnostics()
end

return M
