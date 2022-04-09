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

    local config = {
      on_attach = lsp.on_attach,
    }
    lspconfig.rust_analyzer.setup(require("coq").lsp_ensure_capabilities(config))
  end,
}
