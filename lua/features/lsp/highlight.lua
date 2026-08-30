local M = {}

---@param bufnr integer
---@param client vim.lsp.Client
function M.setup(bufnr, client)
  if client:supports_method("textDocument/documentHighlight", bufnr) then
    local group =
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

return M
