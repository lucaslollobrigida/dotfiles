return {
  lazy_load = function(load)
    load "nvim-lsp-ts-utils"
  end,
  plugins = function(use)
    use { "jose-elias-alvarez/nvim-lsp-ts-utils", opt = true }
  end,
  setup = function()
    local ok, _ = pcall(require, "lspconfig")
    if not ok then
      print "Typescript dependends on lsp. The functionality is disable"
      return
    end

    local lsp = require "modules.lsp"
    local ts_utils = require "nvim-lsp-ts-utils"

    require("lspconfig").tsserver.setup {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        ts_utils.setup {
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
        }

        -- required to fix code action ranges
        ts_utils.setup_client(client)
        lsp.on_attach(client, bufnr)
      end,
      root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
      settings = { documentFormatting = false },
    }
  end,
}
