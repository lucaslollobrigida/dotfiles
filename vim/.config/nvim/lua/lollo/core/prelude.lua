----- syntax
vim.bo.syntax = 'ON'
vim.o.termguicolors = true
vim.o.showmode = false

vim.o.mouse = "a"

vim.bo.smartindent = true
vim.o.expandtab = true

---- ruler and cursor line
vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.cursorline = true

----- sane splits
vim.o.splitbelow = true
vim.o.splitright = true

---- disable folding
vim.wo.foldenable = false

----- fill and use clipboard register on text edits
vim.cmd [[set clipboard+=unnamed,unnamedplus]]

--
vim.cmd [[set shortmess+=c]]

----- disable unused default plugins
vim.g.loaded_2html_plugin = true

----- automatically write on focus change and load changes from outside vim's to the buffer
vim.o.autoread = true
vim.o.autowrite  = true

----- tweak update and redraw timers
vim.o.updatetime = 200
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.ttimeout = true
vim.o.ttyfast = true
vim.o.lazyredraw = true

----- disable swapfiles
vim.bo.swapfile = false

----- make inccommand opens a split with live preview of the search (neovim only)
vim.o.inccommand = 'split'

vim.o.hidden = true
vim.o.wrap = false

vim.o.undofile = true
vim.o.undolevels = 10000

vim.o.scrolloff = 10

----- completion tweak
vim.o.completeopt = "menu,menuone,noselect"
