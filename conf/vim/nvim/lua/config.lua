local M = {
  auto_complete = true,
  colorscheme = "embark",
  hidden_files = true,
  wrap_lines = false,
  shell = "zsh",

  -- @usage pass a table with your desired languages
  treesitter = {
    ensure_installed = "maintained",
  },
  paths = {
    data = vim.fn.stdpath "data",
    cache = vim.fn.stdpath "cache",
  },
  lua = {
    formatter = "luafmt",
    autoformat = true,
  },
  sh = {
    linter = "shellcheck",
    formatter = "shfmt",
    autoformat = false,
  },
  tsserver = {
    linter = "eslint",
    formatter = "prettier",
    autoformat = true,
  },

  dashboard = {
    custom_header = {
      "",
      '                                           "',
      "             m mm    mmm    mmm   m   m  mmm    mmmmm",
      '             #"  #  #"  #  #" "#  "m m"    #    # # #',
      '             #   #  #""""  #   #   #m#     #    # # #',
      '             #   #  "#mm"  "#m#"    #    mm#mm  # # #',
      "",
    },
    footer = { "https://github.com/lucaslollobrigida/dotfiles" },
  },
}

return M
