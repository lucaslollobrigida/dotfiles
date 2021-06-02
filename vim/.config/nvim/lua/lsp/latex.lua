local C = require("config")

require("lspconfig").texlab.setup({
  cmd = { C.paths.data .. "/lspinstall/latex/texlab" },
  on_attach = require("lsp").on_attach,
})
