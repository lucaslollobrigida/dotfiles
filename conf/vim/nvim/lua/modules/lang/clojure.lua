return {
  lazy_load = function(load)
    load "conjure"
    load "vim-sexp"
    load "vim-sexp-mappings-for-regular-people"
    load "lispdocs.nvim"
    load "sql.nvim"
  end,
  plugins = function(use)
    local lisps = { "clojure", "scheme", "racket", "lisp", "fennel" }

    use {
      "guns/vim-sexp",
      ft = lisps,
      opt = true,
      requires = { "tpope/vim-sexp-mappings-for-regular-people" },
    }

    use {
      "Olical/conjure",
      ft = lisps,
      opt = true,
      requires = { "Olical/AnsiEsc", "tami5/compe-conjure" },
    }
    use {
      "tami5/lispdocs.nvim",
      ft = lisps,
      opt = true,
      requires = { "tami5/sql.nvim" },
    }
  end,
  setup = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      print "Clojure dependends on lsp. The functionality is disable"
      return
    end

    local lsp = require "modules.lsp"
    -- local cmp = require "cmp_nvim_lsp"
    local coq = require "coq"

    local opts = { noremap = true, silent = true }
    local config = {
      filetypes = { "clojure" },
      -- capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = function(client, bufnr)
        lsp.buf_set_keymap(
          bufnr,
          "n",
          "<leader>lc",
          [[<cmd>lua require('modules.lang.clojure').clojure_clean_ns()<CR>]],
          opts
        )
        lsp.on_attach(client, bufnr)
      end,
      init_options = {
        extendedClientCapabilities = { classFileContentsSupport = true },
      },
    }

    lspconfig.clojure_lsp.setup(coq.lsp_ensure_capabilities(config))

    vim.api.nvim_set_var("sexp_filetypes", "clojure,racket,scheme,lisp,fennel")
    vim.api.nvim_set_var("sexp_no_word_maps", true)

    vim.api.nvim_exec(
      [[
      augroup ConjureLog
      autocmd!
      setlocal scrolloff=0
      augroup END
      ]],
      false
    )
    vim.g["conjure#log#fold#enabled"] = true
    vim.g["conjure#log#wrap"] = true
    vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defflow", "defspec" }

    vim.g["conjure#mapping#doc_word"] = "K"
    vim.g["conjure#client#clojure#nrepl#mapping#run_current_test"] = "tt"

    vim.g["conjure#extract#tree_sitter#enabled"] = true
  end,
  clojure_clean_ns = function()
    local file = require("modules.lsp").current_file_url()
    vim.lsp.buf.execute_command { command = "clean-ns", arguments = { file, 1, 1 } }
  end,
}
