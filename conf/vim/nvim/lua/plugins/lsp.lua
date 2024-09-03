return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      underline = true,
    },
  },
  keys = {
    {
      "<leader>lf",
      function()
        vim.lsp.buf.format({ async = true })
      end,
      desc = "Format file",
    },
  },
}
