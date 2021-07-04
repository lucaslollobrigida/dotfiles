local lsp = require("lsp")
local ts_utils = require("nvim-lsp-ts-utils")

require("lspconfig").tsserver.setup({
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false

    ts_utils.setup({
      enable_import_on_completion = true,
      import_all_timeout = 5000,

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = true,

      -- formatting
      enable_formatting = false,
      formatter = "prettier",
      formatter_config_fallback = nil,

      -- parentheses completion
      complete_parens = true,
      signature_help_in_parens = false,

      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
    })

    -- required to fix code action ranges
    ts_utils.setup_client(client)
    lsp.on_attach(client, bufnr)
  end,
  root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  settings = { documentFormatting = false },
})
