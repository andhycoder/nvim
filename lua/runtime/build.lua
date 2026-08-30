local M = {}

local function fff_build()
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if name == "fff" and (kind == "install" or kind == "update") then
        if not ev.data.active then
          vim.cmd.packadd("fff")
        end
        require("fff.download").download_or_build_binary()
      end
    end,
  })
end

function M.setup()
  -- fff_build()
end

return M
