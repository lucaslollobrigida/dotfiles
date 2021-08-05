local C = require "config"

require("nvim-treesitter.configs").setup {
  ensure_installed = C.treesitter.ensure_installed,
  ignore_install = C.treesitter.ignore_install,
  highlight = {
    enable = true,
    use_languagetree = false,
  },
  playground = {
    enabled = true,
  },
  rainbow = {
    enabled = true,
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
}
