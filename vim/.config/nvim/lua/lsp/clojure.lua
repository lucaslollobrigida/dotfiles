local lsp = require("lsp")
local opts = { noremap = true, silent = true }

local M = {}

M.clojure_clean_ns = function()
  local file = lsp.current_file_url()
  vim.lsp.buf.execute_command({ command = "clean-ns", arguments = { file, 1, 1 } })
end

require("lspconfig").clojure_lsp.setup({
  on_attach = function(client, bufnr)
    lsp.buf_set_keymap(bufnr, "n", "<leader>lc", [[<cmd>lua require('lsp.clojure').clojure_clean_ns()<CR>]], opts)
    lsp.on_attach(client, bufnr)
  end,
  init_options = {
    extendedClientCapabilities = { classFileContentsSupport = true },
  },
})

return M
