local config = require('lollo.config')
Packadd [[vim-nightfly-guicolors]]

-- nightgly colorscheme
vim.g.nightflyUnderlineMatchParen = true
vim.g.nightflyCursorColor = true
vim.g.nightflyTransparent = true

Packadd [[vim-devicons]]
Packadd [[vim-fugitive]]

vim.cmd('colorscheme ' .. config.colorscheme)

vim.wo.signcolumn = 'yes:1'
vim.g.embark_terminal_italics = true

vim.cmd("hi link xmlEndTag xmlTag")
vim.cmd("hi htmlArg gui=italic")
vim.cmd("hi Comment gui=italic")
vim.cmd("hi Type gui=italic")
vim.cmd("hi htmlArg cterm=italic")
vim.cmd("hi Type cterm=italic")
