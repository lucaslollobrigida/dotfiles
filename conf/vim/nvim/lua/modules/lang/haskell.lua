return {
  lazy_load = function(load) end,
  plugins = function(use) end,
  setup = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      print "Haskell dependends on lsp. The functionality is disable"
      return
    end

    lspconfig.hls.setup {
      cmd = { "haskell-language-server", "--lsp" },
      on_attach = require("modules.lsp").on_attach,
      -- capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
  end,
}
