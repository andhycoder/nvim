local M = {}

function M.run()
  local inactive = vim
    .iter(vim.pack.get())
    :filter(function(plugin)
      return not plugin.active
    end)
    :map(function(plugin)
      return plugin.spec.name or plugin.spec.src
    end)
    :totable()

  if #inactive > 0 then
    vim.notify(
      "Removing inactive plugins:\n" .. table.concat(inactive, "\n"),
      vim.log.levels.INFO
    )
    vim.pack.del(inactive)
  else
    vim.notify("No inactive plugins found.", vim.log.levels.INFO)
  end

  local cache_path = vim.fn.stdpath("state") .. "/nvimz_cache.json"
  if vim.fn.filereadable(cache_path) == 1 then
    vim.fn.delete(cache_path)
    vim.notify("Cleared state cache file.", vim.log.levels.INFO)
  end

  local snapshot_dir = vim.fn.stdpath("config") .. "/snapshots"
  if vim.fn.isdirectory(snapshot_dir) == 1 then
    local snapshots =
      vim.fn.globpath(snapshot_dir, "snapshot_*.json", true, true)
    if #snapshots > 5 then
      for i = 1, #snapshots - 5 do
        vim.fn.delete(snapshots[i])
        vim.notify(
          "Removed old snapshot: " .. snapshots[i],
          vim.log.levels.INFO
        )
      end
    end
  end
  vim.notify("󰄬 PackClean complete.", vim.log.levels.INFO)
end

return M
