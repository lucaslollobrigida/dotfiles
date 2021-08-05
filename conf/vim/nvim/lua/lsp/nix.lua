local lsp = require "lsp"

require("lspconfig").rnix.setup {
  cmd = { "rnix-lsp" },
  on_attach = lsp.on_attach,
  filetypes = { "nix" },
}
