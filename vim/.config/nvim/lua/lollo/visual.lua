local globals = require('lollo.config')
Packadd [[vim-nightfly-guicolors]]

-- nightgly colorscheme
vim.g.nightflyUnderlineMatchParen = true
vim.g.nightflyCursorColor = true
vim.g.nightflyTransparent = true

Packadd [[vim-devicons]]
Packadd [[vim-fugitive]]

vim.cmd('colorscheme ' .. globals.colorscheme)

vim.wo.signcolumn = 'yes:1'
