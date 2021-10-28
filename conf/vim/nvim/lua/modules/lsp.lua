local buf_set_option = function(bufnr, ...)
  vim.api.nvim_buf_set_option(bufnr, ...)
end

local buf_set_keymap = function(bufnr, ...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end

local on_attach = function(client, bufnr)
  buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }

  local keys = {
    { "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts },
    { "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts },
    { "n", "gD", "<cmd>lua require('modules.telescope').lsp_references()<CR>", opts },
    { "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts },
    { "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts },
    { "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts },
    { "n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", opts },
    { "n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", opts },
    { "n", "<leader>d", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts },
    { "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts },
    { "n", "<leader>a", "<cmd>lua require('modules.telescope').lsp_code_action()<CR>", opts },
    { "v", "<leader>a", "<cmd>lua require('modules.telescope').lsp_range_code_action()<CR>", opts },
  }

  for _, key in ipairs(keys) do
    buf_set_keymap(bufnr, key[1], key[2], key[3], key[4]) -- is there an apply-like in lua? (apply bufnr key)
  end

  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap(bufnr, "v", "<leader>lf", [[<cmd>'<,'>lua vim.lsp.buf.formatting()<cr>]], opts)
  end

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
    vim.api.nvim_exec(
      [[
      augroup lsp_formatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
      augroup END
      ]],
      false
    )
  end

  vim.api.nvim_exec(
    [[
    augroup lsp_hover
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
    autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.signature_help()
    augroup END
    ]],
    false
  )

  if client.resolved_capabilities.code_lens then
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

return {
  lazy_load = function(load)
    load "nvim-lspconfig"
    load "lspkind-nvim"
    load "lsp-colors.nvim"
    load "nvim-dap"
    load "trouble.nvim"
    load "nvim-web-devicons"
    load "null-ls.nvim"

    load "nvim-cmp"
    load "cmp-nvim-lsp"
    load "cmp-vsnip"
    load "vim-vsnip"
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

    use {
      "hrsh7th/nvim-cmp",
      opt = true,
      requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip" },
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

    vim.cmd "highlight default link LspCodeLens Comment"
    vim.cmd "highlight default link LspCodeLensSign LspCodeLens"
    vim.cmd "highlight default link LspCodeLensSeparator LspCodeLens"

    local cmp = require "cmp"

    cmp.setup {
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm { select = true },
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
      },
      formatting = {
        format = require("lspkind").cmp_format { with_text = false, maxwidth = 50 },
      },
    }

    vim.cmd [[
    imap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<C-j>'
    smap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<C-j>'
    imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
    smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
    ]]

    require("nvim-autopairs.completion.cmp").setup {
      map_cr = true, --  map <CR> on insert mode
      map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
      auto_select = true, -- automatically select the first item
      insert = false, -- use insert confirm behavior instead of replace
      map_char = { -- modifies the function or method delimiter by filetypes
        all = "(",
        clojure = "",
        tex = "{",
      },
    }

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
