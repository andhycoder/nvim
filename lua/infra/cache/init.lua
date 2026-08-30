local M = {}
local state = require("infra.cache.state")

---@param key string
---@return table
function M.get(key)
  return state.load()[key]
end

---@param key string
---@param value table|unknown
function M.set(key, value)
  state.load()[key] = value
  state.save()
end

return M
