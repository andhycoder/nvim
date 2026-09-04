local M = {}

function M.setup()
  vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          cargo = {
            buildScripts = {
              enable = true,
            },
            allTargets = false,
          },
          check = {
            command = "clippy",
            extraArgs = {
              "--no-deps",
              "--",
              "-D",
              "clippy::all",
              "-D",
              "clippy::perf",
              "-W",
              "clippy::correctness",
              "-W",
              "clippy::pedantic",
              "-W",
              "clippy::style",
              "-W",
              "clippy::nursery",
              "-W",
              "clippy::complexity",
            },
            allTargets = false,
          },
          files = {
            exclude = { ".git", "target", "node_modules" },
          },
          lens = {
            enable = true,
          },
          procMacro = {
            enable = true,
          },
          inlayHints = {
            bindingModeHints = { enable = false },
            chainingHints = { enable = true },
            closingBraceHints = { enable = true, minLines = 25 },
            closureReturnTypeHints = { enable = "never" },
            lifetimeElisionHints = {
              enable = "never",
              useParameterNames = false,
            },
            maxLength = 25,
            parameterHints = { enable = true },
            reborrowHints = { enable = "never" },
            renderColons = true,
            typeHints = {
              enable = true,
              hideClosureInitialization = false,
              hideNamedTempTypes = false,
            },
          },
        },
      },
    },
  }
end

return M
