local C = require "config"

require("nvim-treesitter.configs").setup {
  ensure_installed = C.treesitter.ensure_installed,
  ignore_install = C.treesitter.ignore_install,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
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
