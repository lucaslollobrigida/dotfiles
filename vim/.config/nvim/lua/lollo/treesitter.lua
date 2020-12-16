local has_treesitter = pcall(vim.cmd, [[packadd nvim-treesitter]])
if not has_treesitter then
  print('[Treesitter] nvim-treesitter is required for this package.')
  return
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    use_languagetree = false,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = false,
  }
}

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
