local lsp = require('lsp')

require("flutter-tools").setup {
  experimental = {
    lsp_derive_paths = true,
  },
  debugger = {
    enabled = false,
  },
  widget_guides = {
    enabled = false,
  },
  closing_tags = {
    enabled = true,
  },
  outline = {
    open_cmd = "40vnew",
  },
  lsp = {
    on_attach = lsp.on_attach,
    -- capabilities = my_custom_capabilities,
    settings = {
      showTodos = true,
      completeFunctionCalls = true
    }
  }
}
