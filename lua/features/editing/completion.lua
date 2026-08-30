local M = {}

local function get_mini_icons(ctx)
  if ctx.source_name == "Path" then
    local is_unknown_type = vim.tbl_contains(
      { "link", "socket", "fifo", "char", "block", "unknown" },
      ctx.item.data.type
    )
    local mini_icon, mini_hl, _ = require("mini.icons").get(
      is_unknown_type and "os" or ctx.item.data.type,
      is_unknown_type and "" or ctx.item.data.type
    )
    if mini_icon then
      return mini_icon, mini_hl
    end
  end
  local mini_icon, mini_hl, _ = require("mini.icons").get("lsp", ctx.kind)
  return mini_icon, mini_hl
end

function M.setup()
  vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
  vim.opt.completeitemalign = { "kind", "abbr", "menu" }

  require("mini.completion").setup {
    lsp_completion = {
      source_func = "completefunc",
      auto_setup = true,
    },
    window = {
      info = { border = "rounded" },
      signature = { border = "rounded" },
    },
  }

  -- Set up Tab/S-Tab for smooth command-line/insert completion navigation
  -- Note: Neovim 0.12+ handles Tab/S-Tab for snippets by default.
  -- We only need custom logic if we want to integrate it with pumvisible()
  -- but Neovim 0.12's default is already quite smart.
end

function M.setup_blink()
  require("blink.cmp").build():wait()

  require("blink.cmp").setup {
    snippets = {
      preset = "default",
    },
    fuzzy = {
      implementation = "rust",
      sorts = {
        "score",
        "exact",
        "sort_text",
        "label",
      },
      use_proximity = true,
    },
    keymap = {
      ["<C-Space>"] = { "show", "fallback" },
      ["<C-d>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<S-Tab>"] = {
        "select_prev",
        "fallback",
      },
      ["<Tab>"] = {
        "select_next",
        function(cmp)
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))

          local has_words_before = col ~= 0
            and vim.api
                .nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match("%s")
              == nil

          if has_words_before then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<C-h>"] = {
        "snippet_backward",
        "fallback",
      },
      ["<C-l>"] = {
        "snippet_forward",
        "fallback",
      },
      ["<C-k>"] = {
        "show_signature",
        "hide_signature",
        "fallback",
      },
      preset = "none",
    },
    completion = {
      menu = {
        auto_show = true,
        winblend = 10,
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", gap = 1, "kind" },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, kind_hl = get_mini_icons(ctx)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl = get_mini_icons(ctx)
                return hl
              end,
            },
            kind = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl = get_mini_icons(ctx)
                return hl
              end,
            },
          },
        },
        direction_priority = function()
          local ctx = require("blink.cmp").get_context()
          local item = require("blink.cmp").get_selected_item()

          if ctx == nil or item == nil then
            return { "s", "n" }
          end

          local item_text = item.textEdit ~= nil and item.textEdit.newText
            or item.insertText
            or item.label
          local is_multi_line = item_text:find("\n") ~= nil

          if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
            vim.g.blink_cmp_upwards_ctx_id = ctx.id
            return { "n", "s" }
          end
          return { "s", "n" }
        end,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        treesitter_highlighting = true,
        window = {
          border = "rounded",
          winblend = 10,
        },
      },
      ghost_text = {
        enabled = true,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },
    sources = {
      default = function(ctx)
        local ok, node = pcall(vim.treesitter.get_node)
        if
          ok
          and node
          and vim.tbl_contains(
            { "comment", "line_comment", "block_comment" },
            node:type()
          )
        then
          return { "buffer" }
        else
          return { "lsp", "path", "snippets", "buffer" }
        end
      end,
      -- default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        gitcommit = { "snippets", "buffer" },
        markdown = { "buffer", "snippets", "path" },
      },
      providers = {
        lsp = {
          opts = {
            tailwind_color_icon = "󱓻",
          },
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winblend = 10,
      },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "normal",
    },
  }
end

function M.native_compl()
  local ms = vim.lsp.protocol.Methods
  local group =
    vim.api.nvim_create_augroup("native_completion", { clear = true })

  vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
  vim.opt.completeitemalign = { "kind", "abbr", "menu" }
end

return M
