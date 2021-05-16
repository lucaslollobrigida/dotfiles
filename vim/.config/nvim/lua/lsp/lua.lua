local C = require("config")
local lsp = require("lsp")

-- local sumneko_root_path = C.paths.data .. "/lspinstall/lua"
-- local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

require("nlua.lsp.nvim").setup(require("lspconfig"), {
  on_attach = lsp.on_attach,
  globals = {
    "jit",
    "vim",
    "awesome",
    "window",
    "root",
    "client",
    "it",
    "describe",
    "before_each",
    "after_each",
  },
})
