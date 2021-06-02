local M = {}
local saga = require("lspsaga")

saga.init_lsp_saga({
  use_saga_diagnostic_sign = true,
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  dianostic_header_icon = "   ",
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = false,
    virtual_text = false,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 50, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = "<CR>",
    vsplit = "<c-v>",
    quit = "<ESC>",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "<ESC>",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<ESC>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  server_filetype_map = { metals = { "sbt", "scala" } },
})

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981",
})

require("trouble").setup()
require("todo-comments").setup()

M.buf_set_keymap = function(bufnr, ...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end

M.buf_set_option = function(bufnr, ...)
  vim.api.nvim_buf_set_option(bufnr, ...)
end

M.on_attach = function(client, bufnr)
  M.buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }
  M.buf_set_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  M.buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  M.buf_set_keymap(bufnr, "n", "gD", [[<cmd>lua R('plugins.telescope').lsp_references()<CR>]], opts)
  M.buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- check if server supports
  M.buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  M.buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  M.buf_set_keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_prev()<cr>", opts)
  M.buf_set_keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_next()<cr>", opts)
  M.buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts)
  M.buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  M.buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts)
  M.buf_set_keymap(bufnr, "v", "<leader>a", [[<cmd>'<,'>Lspsaga range_code_action<CR>]], opts)

  M.buf_set_keymap(bufnr, "i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })
  M.buf_set_keymap(bufnr, "i", "<C-y>", "compe#confirm()", { noremap = true, silent = true, expr = true })

  if client.resolved_capabilities.document_range_formatting then
    M.buf_set_keymap(bufnr, "v", "<leader>lf", [[<cmd>'<,'>lua vim.lsp.buf.formatting()<cr>]], opts)
  end

  if client.resolved_capabilities.document_formatting then
    M.buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
  end

  vim.cmd([[autocmd CursorHold <buffer> lua require('lsp').show_line_diagnostics()]])

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
            hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]],
      false
    )
  end
end

vim.fn.sign_define("LspDiagnosticsSignError", { text = "", texthl = "LspDiagnosticsSignError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", texthl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", texthl = "LspDiagnosticsSignInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", texthl = "LspDiagnosticsSignHint" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  -- update_in_insert = false,
})

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)",
}

--[[ " autoformat
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100) ]]
-- Java
-- autocmd FileType java nnoremap ca <Cmd>lua require('jdtls').code_action()<CR>
--

M.current_file_url = function()
  local file = vim.api.nvim_eval([[expand('%:p')]])
  return string.format("file://%s", file)
end

M.tsserver_on_attach = function(client, bufnr)
  M.on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
end

M.show_line_diagnostics = function()
  vim.lsp.diagnostic.show_line_diagnostics({
    border = "single",
  })
end

M.next_diagnostic = function()
  vim.lsp.diagnostic.goto_next({
    popup_opts = { border = "single" },
  })
end

M.prev_diagnostic = function()
  vim.lsp.diagnostic.goto_prev({
    popup_opts = { border = "single" },
  })
end

return M
