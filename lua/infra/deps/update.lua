local M = {}

local git = require("infra.deps.git")

---@return table
function M.check()
  local plugins = vim.pack.get()
  local results = {}

  for _, plugin in ipairs(plugins) do
    local name = plugin.spec.name or plugin.spec.src
    io.write(string.format(" 󰆓 %-20s", name))
    io.flush()

    vim.system({ "git", "-C", plugin.path, "fetch", "origin", "--quiet" }):wait()

    local branch = git.get_default_branch(plugin.path)
    local local_rev = vim
      .system({ "git", "-C", plugin.path, "rev-parse", "HEAD" }, { text = true })
      :wait().stdout
      :gsub("\n", "")
    local remote_rev = vim
      .system(
        { "git", "-C", plugin.path, "rev-parse", "origin/" .. branch },
        { text = true }
      )
      :wait().stdout
      :gsub("\n", "")

    if local_rev ~= remote_rev then
      vim.notify(
        string.format(" → pending update (%s)", branch),
        vim.log.levels.INFO
      )
      table.insert(results, {
        plugin = plugin,
        branch = branch,
        local_rev = local_rev,
        remote_rev = remote_rev,
      })
    else
      vim.notify(" → up to date", vim.log.levels.INFO)
    end
  end

  return results
end

---@param updates table
function M.apply(updates)
  if #updates == 0 then
    return
  end
  for _, update in ipairs(updates) do
    vim
      .system({
        "git",
        "-C",
        update.plugin.path,
        "checkout",
        "--quiet",
        "origin/" .. update.branch,
      })
      :wait()
  end
end

function M.run()
  vim.notify("󰚰 Checking updates...", vim.log.levels.INFO)
  local updates = M.check()

  if #updates > 0 then
    vim.notify(
      string.format("󰚰 Applying %d updates...", #updates),
      vim.log.levels.INFO
    )
    M.apply(updates)
  else
    vim.notify("󰄬 Plugins already up to date.", vim.log.levels.INFO)
  end

  require("infra.deps.lockfile").generate()
  require("infra.health").run()
  require("infra.report.maintenance").run()

  vim.notify("󰄬 Done. Maintenance report updated.", vim.log.levels.INFO)
end

return M
