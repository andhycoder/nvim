local M = {}

local treesitter = require("nvim-treesitter")
local ensure_installed = require("infra.registry.parsers").required
local LARGE_TREESITTER_FILE_BYTES = 500 * 1024

---@param bufnr integer
---@return boolean
local function can_enable_treesitter(bufnr)
  return vim.bo[bufnr].buftype == ""
    and vim.bo[bufnr].filetype ~= ""
    and not vim.b[bufnr].large_file
end

---@param bufnr integer
---@return boolean
local function is_small_enough_for_treesitter(bufnr)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local ok, file_stats = pcall(vim.uv.fs_stat, filepath)
  return not (
    ok
    and file_stats
    and file_stats.size > LARGE_TREESITTER_FILE_BYTES
  )
end

---@param bufnr integer
---@return boolean
local function parser_available(bufnr)
  local ok_parser, parser = pcall(vim.treesitter.get_parser, bufnr)
  return ok_parser and parser ~= nil
end

---@param bufnr integer
local function enable_treesitter(bufnr)
  if
    not can_enable_treesitter(bufnr)
    or not is_small_enough_for_treesitter(bufnr)
    or not parser_available(bufnr)
  then
    return
  end

  vim.treesitter.start(bufnr)
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldlevel = 99
end

function M.setup()
  local group =
    vim.api.nvim_create_augroup("native_treesitter", { clear = true })

  treesitter.install(ensure_installed)

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Enable native Treesitter highlighting",
    callback = function(args)
      local ft = vim.bo[args.buf].filetype

      enable_treesitter(args.buf)

      if ft ~= "markdown" and ft ~= "yaml" then
        vim.bo[args.buf].indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.bo[args.buf].smartindent = false
        vim.bo[args.buf].cindent = false
      end
    end,
  })

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      enable_treesitter(bufnr)
    end
  end
end

return M
