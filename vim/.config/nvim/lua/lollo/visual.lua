local globals = require('lollo.globals')
vim.cmd [[packadd vim-nightfly-guicolors]]
vim.cmd [[packadd glow.nvim]]

-- nightgly colorscheme
vim.g.nightflyUnderlineMatchParen = true
vim.g.nightflyCursorColor = true
vim.g.nightflyTransparent = true

-- echodoc
vim.g.echodoc_enable_at_startup = true

-- float-preview
-- vim.g['float_preview#docked'] = 0

local function nvim_multiline_command(command)
  vim.validate { command = { command, 's' } }
  for line in vim.gsplit(command, "\n", true) do
    vim.api.nvim_command(line)
  end
end

nvim_multiline_command [[
  packadd echodoc.vim
  packadd vim-devicons
  packadd vim-fugitive
  packadd vim-signify
]]

-- local function lsp_status()
--   local get_diagnostics  = function(level) vim.lsp.diagnostic.get_count(vim.fn.bufnr('%', level)) end
--   if not vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
--     local errors = get_diagnostics('Error')
--     local warns  = get_diagnostics('Warning')
--     local hints  = get_diagnostics('Hint')
--     if errors == 0 and warns == 0 and hints == 0 then
--       return '  '
--     end
--     return '  × ' .. errors .. ' ! ' .. warns .. ' i ' .. hints
--   end
--   return ''
-- end

vim.cmd('colorscheme ' .. globals.colorscheme)
vim.g.signify_priority = 5
vim.wo.signcolumn = 'yes:1'
