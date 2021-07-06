local lsp = require("lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

vim.g.metals_use_global_executable = true

local M = {}

M.settings = {
  on_attach = lsp.on_attach,
  settings = {
    showImplicitArguments = true,
    superMethodLensesEnabled = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  },
  capabilities = capabilities,
}

vim.api.nvim_exec(
  [[
    augroup metals_lsp
    autocmd!
    autocmd FileType scala,sbt lua require('metals').initialize_or_attach(require('lsp.scala').settings)
    autocmd FileType scala,sbt nnoremap <buffer> <localleader>a <cmd>lua require("telescope").extensions.metals.commands()<CR>
    augroup END
    ]],
  false
)

return M
