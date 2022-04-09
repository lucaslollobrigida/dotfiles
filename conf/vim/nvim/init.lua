require "prelude"

require "common"
require "keymappings"

-- local vim.g.coq_settings = { a = 1 }
vim.g.coq_settings = {
  auto_start = "shut-up",
  clients = {
    buffers = {
      enabled = false,
    },
    lsp = {
      enabled = true,
      resolve_timeout = 3.0,
      weight_adjust = 1.5
    },
    paths = {
      enabled = true,
      weight_adjust = -1
    },
    snippets = {
      enabled = true,
      weight_adjust = 2
    },
    tags = {
      enabled = false,
    },
    tmux = {
      enabled = false,
    },
    tree_sitter = {
      enabled = false,
    },
  },

  -- ["clients.lsp"] = { weight_adjust = 1.4 },
  -- ["clients.tmux.enabled"] = false,
  -- ["clients.buffers.enabled"] = false,
  -- ["clients.tree_sitter.enabled"] = false,
  -- ["clients.tags.enabled"] = false,
}

require "plugins"

require("modules.telescope").setup()
require("modules.treesitter").setup()
require("modules.lsp").setup()
require("modules.file_browser").setup()
require("modules.git").setup()
require("modules.ui").setup()
require("modules.project").setup()

require("modules.lang.clojure").setup()
require("modules.lang.dart").setup()
require("modules.lang.go").setup()
require("modules.lang.haskell").setup()
require("modules.lang.lua").setup()
require("modules.lang.rust").setup()
require("modules.lang.scala").setup()
require("modules.lang.typescript").setup()
