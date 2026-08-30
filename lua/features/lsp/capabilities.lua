local M = {}

function M.setup()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local ok, blink_cmp = pcall(require, "blink.cmp")
  if ok then
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      blink_cmp.get_lsp_capabilities({}, false)
    )
  end

  return capabilities
end

return M
