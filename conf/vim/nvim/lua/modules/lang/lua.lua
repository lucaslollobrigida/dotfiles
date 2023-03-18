return {
  lazy_load = function(load) end,
  plugins = function(use) end,
  setup = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      print "Lua dependends on lsp. The functionality is disable"
      return
    end

    local lsp = require "modules.lsp"
    local cmp = require "cmp_nvim_lsp"

    lspconfig.lua_ls.setup {
      cmd = { "lua-language-server" },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        lsp.on_attach(client, bufnr)
      end,
      capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = { "awesome", "client", "root", "screen", "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.expand "etc/nixos/conf"] = true,
            },
          },
        },
      },
    }
  end,
}
