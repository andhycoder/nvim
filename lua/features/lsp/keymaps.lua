local M = {}

---@param bufnr integer
function M.setup(bufnr)
  ---@param lhs string
  ---@param rhs string|function
  ---@param desc string
  local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, {
      buffer = bufnr,
      silent = true,
      desc = desc,
    })
  end

  -- Navigation
  map("gd", function()
    vim.lsp.buf.definition {
      on_list = function(opt)
        -- custom logic to avoid showing multiple definition when you use this style of code:
        -- `local M.my_fn_name = function() ... end`.

        local unique_defs = {}
        local def_loc_hash = {}

        -- each item in opt.items contain the location into for a definition provided by LSP server
        for _, def_location in pairs(opt.items) do
          -- use filename and line number to uniquelly identify a definition,
          -- we do not expect/want multiple definition in single line!
          local hash_key = def_location.filename .. def_location.lnum

          if not def_loc_hash[hash_key] then
            def_loc_hash[hash_key] = true
            table.insert(unique_defs, def_location)
          end
        end

        opt.items = unique_defs

        -- set the location list
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.fn.setloclist(0, {}, " ", opt)

        -- open the location list when we have more than 1 definition found,
        -- otherwise, jump directly to the definition
        if #opt.items > 1 then
          vim.cmd.lopen()
        else
          vim.cmd([[silent! lfirst]])
        end
      end,
    }
  end, "LSP: go to definition")
  map("gD", vim.lsp.buf.declaration, "LSP: go to declaration")
  map("gi", vim.lsp.buf.implementation, "LSP: go to implementation")
  map("gy", vim.lsp.buf.type_definition, "LSP: go to t[y]pe definition")
  map("K", vim.lsp.buf.hover, "LSP: hover")

  -- Actions
  map("<leader>rn", vim.lsp.buf.rename, "LSP: rename")
  map("<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
  map("<leader>cc", vim.lsp.codelens.run, "LSP: run codelens")
  map(
    "<leader>cwa",
    vim.lsp.buf.add_workspace_folder,
    "LSP: add workspace folder"
  )
  map(
    "<leader>cwr",
    vim.lsp.buf.remove_workspace_folder,
    "LSP: remove workspace folder"
  )
  map("<leader>cwl", function()
    vim.print(vim.lsp.buf.list_workspace_folders())
  end, "LSP: list workspace folder")

  -- Diagnostics
  map("gl", vim.diagnostic.open_float, "Diagnostics: line diagnostics")
end

return M
