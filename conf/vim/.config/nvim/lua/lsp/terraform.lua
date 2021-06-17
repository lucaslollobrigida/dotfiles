require("lspconfig").terraformls.setup({
  cmd = { "terraform-lsp" },
  filetypes = { "terraform" },
  on_attach = require("lsp").on_attach,
})
