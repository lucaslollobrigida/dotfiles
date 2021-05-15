local C = require('config')

require'lspconfig'.terraformls.setup{
    cmd = {C.paths.data .. "/lspinstall/terraform/terraform-ls", "serve"},
    on_attach = require('lsp').on_attach,
}
