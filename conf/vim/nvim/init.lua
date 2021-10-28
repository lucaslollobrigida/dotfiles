require "prelude"

require "common"
require "keymappings"

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
require("modules.lang.lua").setup()
require("modules.lang.scala").setup()
require("modules.lang.typescript").setup()
