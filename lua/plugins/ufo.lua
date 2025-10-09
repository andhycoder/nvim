return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    -- Fold options
    vim.o.foldcolumn = "1" -- '0' is default
    vim.o.foldlevel = 99 -- feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Keymaps for folding
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)

    -- Provider setup
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" } -- prioritize LSP, fallback to indent
      end,
    })
  end,
}
