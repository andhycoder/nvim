local M = {}

function M.run()
  local path = vim.fn.stdpath("config") .. "/nvim-pack-lock.json"
  local f = io.open(path, "r")
  if not f then
    vim.notify("❌ Lockfile missing!", vim.log.levels.ERROR)
    return
  end
  local content = f:read("*a")
  f:close()

  local lock = vim.json.decode(content)
  local plugins = vim.pack.get()

  vim.notify(
    "󰚰 Rolling back plugins to lockfile state...",
    vim.log.levels.INFO
  )
  for _, plugin in ipairs(plugins) do
    local name = plugin.spec.name or plugin.spec.src
    local entry = lock.plugins[name]
    if entry and entry.rev then
      vim.notify(
        "  Resetting " .. name .. " to " .. entry.rev:sub(1, 7) .. "...",
        vim.log.levels.INFO
      )
      vim
        .system({ "git", "-C", plugin.path, "checkout", "--quiet", entry.rev })
        :wait()
    else
      vim.notify("  ⚠️ No lockfile entry for " .. name, vim.log.levels.WARN)
    end
  end
  vim.notify("󰄬 Rollback complete.", vim.log.levels.INFO)
end

return M
