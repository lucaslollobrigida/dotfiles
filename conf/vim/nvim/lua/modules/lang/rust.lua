return {
  lazy_load = function(load) end,
  plugins = function(use) end,
  setup = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      print "Rust dependends on lsp. The functionality is disable"
      return
    end

    local lsp = require "modules.lsp"

    lspconfig.rust_analyzer.setup {
      on_attach = lsp.on_attach,
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
  end,
}
