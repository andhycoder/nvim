local M = {}

local ui = require("infra.view")

---Check a single lua file for syntax errors using loadfile
---@param filepath string
---@return boolean ok, string|nil err
local function check_syntax(filepath)
  local chunk, err = loadfile(filepath)
  if not chunk then
    return false, err
  end
  return true, nil
end

---Run unit test on all lua configuration files
function M.run()
  local config_dir = vim.fn.stdpath("config") .. "/lua"
  local files = vim.fs.find(function(name, _)
    return name:sub(-4) == ".lua"
  end, { path = config_dir, limit = math.huge, type = "file" })

  local total = #files
  local passed = 0
  local failed = 0
  local errors = {}

  for _, file in ipairs(files) do
    local rel_path = file:sub(#config_dir + 2)
    local ok, err = check_syntax(file)
    if ok then
      passed = passed + 1
    else
      failed = failed + 1
      table.insert(errors, { path = rel_path, error = err })
    end
  end

  local lines = {
    "# NvimConfig Test Results",
    "Date: " .. os.date("%Y-%m-%d %H:%M:%S"),
    "",
    string.format("Summary: **%d/%d** files passed (%d failed)", passed, total, failed),
    "",
  }

  if failed > 0 then
    table.insert(lines, "## ❌ Failures")
    for _, item in ipairs(errors) do
      table.insert(lines, string.format("- **`%s`**", item.path))
      table.insert(lines, "  ```text")
      table.insert(lines, "  " .. tostring(item.error))
      table.insert(lines, "  ```")
    end
  else
    table.insert(lines, "✅ All Lua configuration files syntax check passed!")
  end

  ui.show_in_buffer("NvimTest", lines)
end

function M.setup()
  vim.api.nvim_create_user_command("NvimTest", function()
    M.run()
  end, { desc = "Run Lua config files syntax test" })
end

return M
