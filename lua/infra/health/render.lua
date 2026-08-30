local M = {}

local function line()
  print(string.rep("─", vim.o.columns))
end

function M.section(title)
  print("")
  line()
  print(" " .. title)
  line()
end

---@param info table
function M.tool(info)
  local status = info.installed and "OK" or "MISSING"

  local version = info.version or ""

  print(string.format(" %-22s %-10s %s", info.name, status, version))
end

return M
