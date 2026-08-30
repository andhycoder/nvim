-- Enable Lua bytecode cache loader
if vim.loader and vim.loader.enable then
  vim.loader.enable()
end

if jit then
  jit.opt.start(
    "3",
    "maxmcode=1024",
    "maxtrace=4000",
    "maxrecord=4000",
    "maxside=150",
    "hotloop=15",
    "hotexit=10"
  )
end

require("vim._core.ui2").enable {
  enable = true,
  msg = {
    target = "cmd", -- options: cmd(classic), msg(similar to noice)
    pager = { height = 1 },
    msg = { height = 0.5, timeout = 4500 },
    dialog = { height = 0.5 },
    cmd = { height = 0.5 },
  },
}
