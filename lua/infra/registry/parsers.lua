local M = {}

M.required = {
  "c",
  "cpp",
  "go",
  "rust",
  "python",
  "typescript",
  "tsx",
  "lua",
  "luadoc",
  "vim",
  "vimdoc",
  "git_rebase",
  "diff",
  "markdown",
  "markdown_inline",
  "json",
  "yaml",
  "regex",
  "scss",
  "css",
  "html",
  "latex",
  "bash",
  "yuck",
  "zsh",
}

M.required_set = {}
for _, lang in ipairs(M.required) do
  M.required_set[lang] = true
end

return M
