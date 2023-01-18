return {
  lazy_load = function(load)
    load "nvim-jdtls"
  end,
  plugins = function(use)
    use { "mfussenegger/nvim-jdtls", opt = true }
  end,
  setup = function()
    local ok, _ = pcall(require, "lspconfig")
    if not ok then
      print "Java dependends on lsp. The functionality is disable"
      return
    end

    vim.api.nvim_exec(
      [[
      augroup jdt_lsp
      autocmd!
      autocmd FileType java lua require('jdtls').start_or_attach(require('modules.lang.java').lsp_config())
      augroup END
      ]],
      false
    )
  end,
  lsp_config = function()
    local jdtls = require "jdtls"
    local lsp = require "modules.lsp"
    local cmp = require "cmp_nvim_lsp"

    local root_markers = { "gradlew", ".git" }
    local root_dir = require("jdtls.setup").find_root(root_markers)
    local workspace_folder = vim.fn.expand("$HOME/.local/share/jdt.ls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"))

    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    return {
      on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }
        lsp.buf_set_keymap(bufnr, "n", "<leader>lc", [[<cmd>lua require'jdtls'.organize_imports()<CR>]], opts)
        lsp.buf_set_keymap(bufnr, "n", "<leader>tt", [[<cmd>lua require'jdtls'.test_nearest_method()<CR>]], opts)
        lsp.buf_set_keymap(bufnr, "n", "<leader>tn", [[<cmd>lua require'jdtls'.test_class()<CR>]], opts)
        lsp.on_attach(client, bufnr)
      end,
      filetypes = { "java", "groovy" },
      capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      cmd = {
        "java",

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        "/home/lollo/Downloads/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

        "-configuration",
        "/home/lollo/Downloads/jdt-language-server/config_linux",

        "-data",
        workspace_folder,
      },

      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-11",
                path = "~/.asdf/installs/java/openjdk-11",
              },
              {
                name = "JavaSE-17",
                path = "~/.asdf/installs/java/openjdk-17",
              },
              -- {
              --   name = "JavaSE-19",
              --   path = "~/.asdf/installs/java/openjdk-19",
              -- },
            },
          },
        },
      },

      init_options = {
        bundles = {},
        extendedClientCapabilities = extendedClientCapabilities,
      },
    }
  end,
}
