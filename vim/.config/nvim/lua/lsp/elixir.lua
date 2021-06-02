local C = require("config")
local lspconfig = require("lspconfig")

lspconfig.elixirls.setup({
  cmd = { C.paths.data .. "/lspinstall/elixir/elixir-ls/language_server.sh" },
  filetypes = { "elixir", "eelixir" },
  root_dir = lspconfig.util.root_pattern("mix.exs", ".git") or vim.loop.os_homedir(),
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
