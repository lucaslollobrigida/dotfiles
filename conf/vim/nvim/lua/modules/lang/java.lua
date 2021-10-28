return {
  lazy_load = function(load) end,
  plugins = function(use) end,
  setup = function()
    local ok, _ = pcall(require, "lspconfig")
    if not ok then
      print "Java dependends on lsp. The functionality is disable"
      return
    end
  end,
}
