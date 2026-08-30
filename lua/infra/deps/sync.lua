local M = {}

local git = require("infra.deps.git")
local ui = require("infra.view")

local MAX_COMMIT_MESSAGES = 20

---@param path string
---@param from_rev string
---@param to_rev string
---@return string[] commits
---@return integer total
local function commits_between(path, from_rev, to_rev)
  local result = vim
    .system({
      "git",
      "-C",
      path,
      "log",
      "--format=%h%x09%s",
      "--max-count=" .. MAX_COMMIT_MESSAGES,
      from_rev .. ".." .. to_rev,
    }, { text = true })
    :wait()

  if result.code ~= 0 then
    return {}, 0
  end

  local count_result = vim
    .system({
      "git",
      "-C",
      path,
      "rev-list",
      "--count",
      from_rev .. ".." .. to_rev,
    }, { text = true })
    :wait()
  local total = count_result.code == 0 and tonumber(count_result.stdout) or 0

  return vim.split(result.stdout, "\n", { trimempty = true }), total
end

---@param lines string[]
---@param commits string[]
---@param total integer
local function append_commit_summary(lines, commits, total)
  if total == 0 then
    table.insert(lines, "Changes: Unable to read commit history.")
    return
  end

  table.insert(lines, string.format("Changes: **%d new commit(s)**", total))
  for _, commit in ipairs(commits) do
    local short_rev, subject = commit:match("^([^\t]+)\t(.*)$")
    table.insert(lines, string.format("- `%s` %s", short_rev, subject))
  end
  if total > #commits then
    table.insert(
      lines,
      string.format("- … and %d more commit(s)", total - #commits)
    )
  end
end

function M.run()
  local plugins = vim.pack.get()
  local lines = {
    "# PackSync: Plugin Update Status",
    "Date: " .. os.date("%Y-%m-%d %H:%M:%S"),
    "",
  }

  vim.notify("󰚰 Checking remote plugin states...", vim.log.levels.INFO)
  for _, plugin in ipairs(plugins) do
    local name = plugin.spec.name or plugin.spec.src
    print("  Fetching " .. name .. "...")
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

    table.insert(lines, "## " .. name)
    table.insert(lines, "Branch: `" .. branch .. "`")
    if local_rev ~= remote_rev then
      table.insert(lines, "Status: ⚠️ **Pending Update**")
      table.insert(lines, "Current revision: `" .. local_rev .. "`")
      table.insert(lines, "Remote revision:  `" .. remote_rev .. "`")
      local commits, total = commits_between(plugin.path, local_rev, remote_rev)
      append_commit_summary(lines, commits, total)
    else
      table.insert(lines, "Status: ✅ **Up to date**")
      table.insert(lines, "Revision: `" .. local_rev .. "`")
    end
    table.insert(lines, "")
  end

  ui.show_in_buffer("PackSync", lines)
end

return M
