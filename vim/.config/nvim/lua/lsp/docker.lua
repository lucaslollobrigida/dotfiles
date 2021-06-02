local C = require("config")

require("lspconfig").dockerls.setup({
  filetypes = { "dockerfile" },
  cmd = { C.paths.data .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver", "--stdio" },
  on_attach = require("lsp").on_attach,
  root_dir = vim.loop.cwd,
})
