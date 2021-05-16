local C = require("config")

require("lspconfig").bashls.setup({
  cmd = { C.paths.data .. "/lspinstall/bash/node_modules/.bin/bash-language-server", "start" },
  on_attach = require("lsp").on_attach,
  filetypes = { "sh", "zsh" },
})
