local C = require("config")

vim.cmd("colorscheme " .. C.colorscheme)

vim.g.embark_terminal_italics = true

vim.cmd("hi link xmlEndTag xmlTag")
vim.cmd("hi htmlArg gui=italic")
vim.cmd("hi Comment gui=italic")
vim.cmd("hi Type gui=italic")
vim.cmd("hi htmlArg cterm=italic")
vim.cmd("hi Type cterm=italic")
