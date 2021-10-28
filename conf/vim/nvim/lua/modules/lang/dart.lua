return {
  lazy_load = function(load)
    load "flutter-tools.nvim"
    load "plenary.nvim"
  end,
  plugins = function(use)
    use { "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim", opt = true }
  end,
  setup = function()
    local has_lsp, _ = pcall(require, "lspconfig")
    if not has_lsp then
      print "Clojure dependends on lsp. The functionality is disable"
      return
    end

    local ok, telescope = pcall(require, "telescope")
    if not ok then
      print "Flutter dependends on telescope. The functionality is disable"
      return
    end

    telescope.load_extension "flutter"

    local lsp = require "modules.lsp"

    require("flutter-tools").setup {
      experimental = {
        lsp_derive_paths = true,
      },
      debugger = {
        enabled = false,
      },
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        enabled = true,
      },
      outline = {
        open_cmd = "40vnew",
      },
      lsp = {
        on_attach = lsp.on_attach,
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
        },
      },
    }

    -- Flutter commands
    vim.api.nvim_exec(
      [[
      augroup fluttertools_cmd
      autocmd!
      autocmd FileType dart nnoremap <leader>lc <cmd>lua require('modueles.lang.dart').flutter_commands()<CR>
      augroup END
      ]],
      false
    )
  end,
  flutter_commands = function()
    require("telescope").extensions.flutter.commands()
  end,
}
