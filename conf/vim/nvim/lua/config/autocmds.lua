-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = augroup("lsp_hover_normal_mode"),
  callback = function()
    vim.diagnostic.open_float()
  end,
})

-- vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
--   group = augroup("lsp_hover_insert_mode"),
--   callback = function()
--     vim.lsp.buf.signature_help()
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  group = augroup("lsp_codelens"),
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})
