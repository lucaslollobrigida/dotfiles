local C = require("config")
local lspconfig = require("lspconfig")

-- TODO: fix this
-- require("go").setup({
--   max_len = 120,
-- })

lspconfig.gopls.setup({
  filetypes = { "go" },
  root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
  on_attach = require("lsp").on_attach,
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
})
