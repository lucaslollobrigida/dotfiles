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

    lspconfig.sumneko_lua.setup {
      cmd = { "lua-language-server" },
      on_attach = lsp.on_attach,
      capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
