return {
  lazy_load = function(load)
    load "nvim-metals"
  end,
  plugins = function(use)
    use { "scalameta/nvim-metals", opt = true }
  end,
  setup = function()
    local has_lsp, _ = pcall(require, "lspconfig")
    if not has_lsp then
      print "Scala dependends on lsp. The functionality is disable"
      return
    end

    local has_telescope, _ = pcall(require, "telescope")
    if not has_telescope then
      print "Scala dependends on telescope. The functionality is disable"
      return
    end

    vim.api.nvim_exec(
      [[
      augroup metals_lsp
      autocmd!
      autocmd FileType scala,sbt lua require('metals').initialize_or_attach(require('modules.lang.scala').setup())
      autocmd FileType scala,sbt nnoremap <buffer> <localleader>a <cmd>lua require("telescope").extensions.metals.commands()<CR>
      augroup END
      ]],
      false
    )

    return {
      on_attach = require("modules.lsp").on_attach,
      capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      init_options = {
        statusBarProvider = "on",
        compilerOptions = {
          isCompletionItemResolve = false,
        },
      },
      -- tvp = {},
      settings = {
        useGlobalExecutable = true,
        showImplicitArguments = true,
        showInferredType = true,
        superMethodLensesEnabled = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl", "akka.stream.javadsl" },
      },
    }
  end,
}
