local C = require("config")
local lspconfig = require("lspconfig")

-- TODO: fix this
require("go").setup(
  {
    max_len = 120
  }
)

require("lspconfig").gopls.setup {
  cmd = {C.paths.data .. "/lspinstall/go/gopls"},
  settings = {
    gopls = {
      analyses = {unusedparams = true},
      staticcheck = true
    }
  },
  root_dir = lspconfig.util.root_pattern(".git", "go.mod", "."),
  init_options = {
    usePlaceholders = true,
    completeUnimported = true
  },
  on_attach = require("lsp").on_attach
}
