return {
  lazy_load = function(load) end,
  plugins = function(use) end,
  setup = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      print "Go dependends on lsp. The functionality is disable"
      return
    end

    lspconfig.gopls.setup {
      filetypes = { "go" },
      root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
      on_attach = require("modules.lsp").on_attach,
      capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      settings = {
        gopls = {
          analyses = { unusedparams = true },
          staticcheck = true,
          usePlaceholders = false,
          completeUnimported = true,
          codelenses = {
            gc_details = true,
            test = true,
            generate = true,
            regenerate_cgo = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
        },
      },
      flags = {
        allow_incremental_sync = true,
      },
    }

    vim.cmd [[autocmd BufWritePre *.go lua require("modules.lang.go").goimports(1000)]]
  end,
  goimports = function(timeout_ms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then
      return
    end
    local actions = result[1].result
    if not actions then
      return
    end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end,
}
