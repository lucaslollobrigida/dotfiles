----- syntax
vim.opt.syntax = "ON"
vim.opt.termguicolors = true
vim.opt.showmode = false

vim.opt.mouse = "a"

vim.opt.smartindent = true
vim.opt.expandtab = true

---- ruler and cursor line
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true

----- sane splits
vim.opt.splitbelow = true
vim.opt.splitright = true

---- disable folding
vim.opt.foldenable = false

----- fill and use clipboard register on text edits
vim.opt.clipboard = "unnamedplus"

----- .
vim.opt.shortmess:append "c"
vim.opt.shortmess:append "W"
-- vim.cmd([[set iskeyword+=-]])

----- disable unused default plugins
vim.g.loaded_2html_plugin = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

----- automatically write on focus change and load changes from outside vim's to the buffer
vim.opt.autoread = true
vim.opt.autowrite = true

----- tweak update and redraw timers
vim.opt.updatetime = 600
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeout = true
vim.opt.ttyfast = true
-- vim.opt.lazyredraw = true

----- disable swapfiles
vim.opt.swapfile = false

----- make inccommand opens a split with live preview of the search (neovim only)
vim.opt.inccommand = "split"

vim.opt.hidden = true
vim.opt.wrap = false

vim.opt.undofile = true
vim.opt.undolevels = 10000

vim.opt.scrolloff = 10

----- Default identatition
vim.opt.ts = 2
vim.opt.sw = 2

----- completion tweak
vim.opt.completeopt:append { "menu", "menuone", "noselect" }

if vim.fn.has "nvim-0.5" then
  vim.cmd [[
     augroup highlight_yank
     au!
     au TextYankPost * silent! lua vim.highlight.on_yank()
     augroup END
   ]]
end

TERMINAL = vim.fn.expand "$TERMINAL"

vim.opt.pumheight = 10
vim.opt.fileencoding = "utf-8"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "99999"

vim.go.t_Co = "256"
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files

vim.opt.cursorline = true
vim.opt.showtabline = 2
vim.opt.signcolumn = "auto:2"

vim.opt.list = true
vim.opt.listchars = {
  tab = ">·",
  trail = "·",
  extends = ">",
  precedes = "<",
  eol = "↲",
}
