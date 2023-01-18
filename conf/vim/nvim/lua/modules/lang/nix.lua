return {
  lazy_load = function(load) end,
  plugins = function(use) end,
  setup = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      print "Nix dependends on lsp. The functionality is disable"
      return
    end

    local lsp = require "modules.lsp"

    lspconfig.rnix.setup {
      cmd = { "rnix-lsp" },
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = lsp.on_attach,
      filetypes = { "nix" },
    }
  end,
}
