local C = require("config")

require("lspconfig").tsserver.setup({
  cmd = { C.paths.data .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  on_attach = require("lsp").on_attach,
  root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  settings = { documentFormatting = false },
})
