local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.eslint_d,
}

null_ls.setup {
  sources = sources,
  on_attach = require("lsp").on_attach,
}
