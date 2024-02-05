return {
  lazy_load = function(load)
    load "flutter-tools.nvim"
    load "plenary.nvim"
    load "dressing.nvim"
  end,
  plugins = function(use)
    use {
      'akinsho/flutter-tools.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
      },
    }
  end,
  setup = function()
    local has_lsp, _ = pcall(require, "lspconfig")
    if not has_lsp then
      print "Dart dependends on lsp. The functionality is disable"
      return
    end

    local ok, telescope = pcall(require, "telescope")
    if not ok then
      print "Dart dependends on telescope. The functionality is disable"
      return
    end

    telescope.load_extension "flutter"

    local lsp = require "modules.lsp"
    local cmp = require "cmp_nvim_lsp"

    require("flutter-tools").setup {
      debugger = {
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
        capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
          analysisExcludedFolders = {vim.fn.expand("$HOME/snap/flutter/packages"), vim.fn.expand("$HOME/.pub-cache")},
          showTodos = true,
          completeFunctionCalls = true,
        },
      },
    }

    vim.api.nvim_exec(
      [[
      augroup fluttertools_cmd
      autocmd!
      autocmd FileType dart nnoremap <leader>lc <cmd>lua require('modules.lang.dart').flutter_commands()<CR>
      augroup END
      ]],
      false
    )
  end,
  flutter_commands = function()
    require("telescope").extensions.flutter.commands()
  end,
}
