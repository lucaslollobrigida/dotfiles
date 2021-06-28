local lsp = require("lsp")
local lspconfig = require("lspconfig")
local lsputil = require("lspconfig/util")

lspconfig.hls.setup({
  cmd = { "haskell-language-server", "--lsp" },
  filetypes = { "haskell", "ihaskell" },
  root_dir = lsputil.root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml", ".git"),
  on_attach = lsp.on_attach,
  settings = {
    languageServerHaskell = {
      formattingProvider = "ormolu"
    }
  }
})
