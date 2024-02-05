return {
  lazy_load = function(load) end,
  plugins = function(use) end,
  setup = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      print "Python dependends on lsp. The functionality is disable"
      return
    end

    local lsp = require "modules.lsp"
    local cmp = require "cmp_nvim_lsp"
    -- local coq = require "coq"

    local config = {
      filetypes = { "python" },
      capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      -- capabilities = coq.lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = lsp.on_attach,
      settings = {
        python = {
          analysis = {
            indexing = true,
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            inlayHints = {
              variableTypes = true,
              functionReturnTypes = true,
            },
          },
          exclude = { ".venv" },
          venvPath = "./.venv/",
          pythonPath = ".venv/bin/python",
          typingsPath = "./typestubs",
        },
      }
    }

    lspconfig.pyright.setup(config)
  end,
}
