local globals = require('lollo.config')
Packadd [[vim-nightfly-guicolors]]
Packadd [[glow.nvim]]

-- nightgly colorscheme
vim.g.nightflyUnderlineMatchParen = true
vim.g.nightflyCursorColor = true
vim.g.nightflyTransparent = true

-- echodoc
vim.g.echodoc_enable_at_startup = true

Packadd [[echodoc.vim]]
Packadd [[vim-devicons]]
Packadd [[vim-fugitive]]
Packadd [[vim-signify]]

vim.cmd('colorscheme ' .. globals.colorscheme)

vim.g.signify_priority = 5
vim.wo.signcolumn = 'yes:1'
