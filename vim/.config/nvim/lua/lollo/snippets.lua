local has_snippets = pcall(vim.cmd, [[packadd ultisnips ]])
if not has_snippets then
  print('[LSP] nvim-lspconfig is required for this package.')
  return
end
