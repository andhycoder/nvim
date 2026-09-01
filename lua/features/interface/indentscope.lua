local M = {}

function M.setup()
  local MiniIndentscope = require("mini.indentscope")
  MiniIndentscope.setup {
    draw = {
      animation = MiniIndentscope.gen_animation.none(),
    },
    symbol = "▏",
  }
end

return M
