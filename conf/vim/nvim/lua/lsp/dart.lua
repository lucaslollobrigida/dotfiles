local lsp = require "lsp"

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
      completeFunctionCalls = true,
    },
  },
}

-- Flutter commands
vim.api.nvim_exec(
  [[
    augroup fluttertools_cmd
    autocmd!
    autocmd FileType dart nnoremap <leader>lc <cmd>lua require('plugins.telescope').flutter_commands()<CR>
    augroup END
    ]],
  false
)
