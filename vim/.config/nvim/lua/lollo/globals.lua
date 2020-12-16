local native_lsp = vim.fn.has('nvim-0.5')
local use_coc = false          -- use coc.nvim instead of builtin LSP
local colorscheme = 'nightfly' -- nightfly, zephyr
local finder = 'telescope'     -- fzf, telescope.nvim
local statusline = ''          -- lightline, galaxyline.nvim

local M = {
  builtin_lsp = native_lsp and not use_coc,
  colorscheme = colorscheme,
  finder = finder,
  statusline = statusline,
}

-- print(vim.inspect(M))

return M
