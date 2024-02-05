local buf_set_option = function(bufnr, ...)
  vim.api.nvim_buf_set_option(bufnr, ...)
end

local buf_set_keymap = function(bufnr, ...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end

local on_attach = function(client, bufnr)
  -- buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }

  local keys = {
    { "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts },
    { "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts },
    { "n", "gD", "<cmd>lua require('modules.telescope').lsp_references()<CR>", opts },
    { "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts },
    { "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts },
    { "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts },
    { "n", "]e", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts },
    { "n", "[e", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts },
    { "n", "<leader>d", "<cmd>lua vim.diagnostic.set_loclist()<cr>", opts },
    { "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts },
    { "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts },
    { "v", "<leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts },
  }

  for _, key in ipairs(keys) do
    buf_set_keymap(bufnr, unpack(key))
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    buf_set_keymap(bufnr, "v", "<leader>lf", [[<cmd>'<,'>lua vim.lsp.buf.format {async = true} <cr>]], opts)
  end

  if client.server_capabilities.documentFormattingProvider then
    buf_set_keymap(bufnr, "n", "<leader>lf", [[<cmd>lua vim.lsp.buf.format {async = true} <cr>]], opts)
    -- vim.api.nvim_exec(
    --   [[
    --   augroup lsp_formatting
    --   autocmd! * <buffer>
    --   autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    --   augroup END
    --   ]],
    --   false
    -- )
  end

  vim.api.nvim_exec(
    [[
    augroup lsp_hover
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.diagnostic.open_float()
    augroup END
    ]],
    false
  )

  -- INFO: removed from above ^
  -- autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.signature_help()

  if client.server_capabilities.codeLensProvider then
    buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)

    vim.api.nvim_exec(
      [[
      augroup lsp_codelens
      autocmd! * <buffer>
      autocmd BufEnter,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
      augroup END
      ]],
      false
    )

    vim.lsp.codelens.refresh()
  end

  if client.server_capabilities.documentHighlightProvider then
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

return {
  lazy_load = function(load)
    load "nvim-lspconfig"
    load "lspkind-nvim"
    load "lsp-colors.nvim"
    load "nvim-dap"
    load "trouble.nvim"
    load "nvim-web-devicons"
    load "null-ls.nvim"
  end,
  plugins = function(use)
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      requires = {
        "onsails/lspkind-nvim",
        "folke/lsp-colors.nvim",
        "mfussenegger/nvim-dap",
        "folke/trouble.nvim",
        "kyazdani42/nvim-web-devicons",
      },
    }

    use { "jose-elias-alvarez/null-ls.nvim", opt = true }
  end,

  setup = function()
    require("lsp-colors").setup {
      Error = "#db4b4b",
      Warning = "#e0af68",
      Information = "#0db9d7",
      Hint = "#10B981",
    }

    require("trouble").setup()
    require("todo-comments").setup()

    vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticHint" })

    vim.diagnostic.config {
      virtual_text = false,
      signs = true,
      underline = true,
    }

    vim.cmd "highlight default link LspCodeLens Comment"
    vim.cmd "highlight default link LspCodeLensSign LspCodeLens"
    vim.cmd "highlight default link LspCodeLensSeparator LspCodeLens"

    local null_ls = require "null-ls"

    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.eslint_d,
    }

    null_ls.setup {
      sources = sources,
      on_attach = on_attach,
    }
  end,

  buf_set_keymap = buf_set_keymap,

  buf_set_option = buf_set_option,

  current_file_url = function()
    local file = vim.api.nvim_eval [[expand('%:p')]]
    return string.format("file://%s", file)
  end,

  on_attach = on_attach,
}
