local has_lsp = pcall(vim.cmd, [[packadd nvim-lspconfig]])
if not has_lsp then
  print('[LSP] nvim-lspconfig is required for this package.')
  return
end

-- TODO: lazy load this packages
vim.cmd [[packadd popfix]]
vim.cmd [[packadd nvim-lsputils]]
vim.cmd [[packadd lsp_extensions.nvim]]
vim.cmd [[packadd nvim-compe]]
vim.cmd [[packadd compe-conjure]]
vim.cmd [[packadd flutter-tools.nvim]]
vim.cmd [[packadd nvim-go]]
vim.cmd [[packadd nlua.nvim]]

local lspconfig = require('lspconfig')
local completion  = require('compe')
-- local lsp_status = require('lsp-status')

-- lsp_status.register_progress()

completion.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;

  source = {
    path = true;
    buffer = true;
    calc = true;
    conjure = true;
    nvim_lsp = true;
    nvim_lua = true;
    treesitter = true;
    spell = false;
    tags = false;
    vsnip = false;
    snippets_nvim = true;
  };
}

local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) -- check if server supports
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<leader>a', [[<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>]], opts)
  buf_set_keymap('n', '<leader>lc', [[<cmd>lua require('lollo.lsp.helpers').clojure_clean_ns()<CR>]], opts)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', '<leader>lf', [[<cmd>'<,'>lua vim.lsp.buf.formatting()<cr>]], opts)
  end

  vim.cmd [[autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]]

  -- if client.name == 'clojure_lsp' then
  -- vim.cmd [[autocmd BufWritePre <buffer> lua require('lollo.lsp.helpers').clojure_clean_ns()]]
  -- end

  buf_set_keymap('i', '<C-Space>', 'compe#complete()', { noremap = true, silent = true, expr = true })
  buf_set_keymap('i', '<C-y>'    , 'compe#confirm()' , { noremap = true, silent = true, expr = true })
  -- buf_set_keymap('i', '<esc>'    , 'compe#close()'   , { noremap = true, silent = true, expr = true })

  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --   require('lspconfig').util.nvim_multiline_command [[
  --   :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  --   :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  --   :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  --   augroup lsp_document_highlight
  --   autocmd!
  --   autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
  --   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()

  --   autocmd BufEnter    <buffer> lua vim.lsp.buf.document_highlight()
  --   autocmd BufLeave    <buffer> lua vim.lsp.buf.clear_references()
  --   augroup END
  -- ]]
  -- end
end

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)
vim.fn.sign_define("LspDiagnosticsSignError",
    {text = "", texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = "", texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = "i", texthl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = "!", texthl = "LspDiagnosticsSignHint"})

local vimls_command = function()
  local cache_location = vim.fn.stdpath('cache')

  return {
    string.format(
      "%s/lspconfig/vim-language-server/bin/index.js",
      cache_location
    ),
    "--stdio",
  }
end

local servers = {
  {'vimls', cmd = vimls_command},
  {'gopls'},
  {'rust_analyzer'},
  {'elixirls'},
  {'clojure_lsp', init_options = {extendedClientCapabilities = {classFileContentsSupport = true}}}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for _, lsp in ipairs(servers) do
  local name = lsp[1]
  local setup = { on_attach = on_attach, capabilities = capabilities }

  if lsp.cmd then
    setup.cmd = lsp.cmd()
  end

  if lsp.settings then
    setup.settings = lsp.settings
  end

  if lsp.init_options then
    setup.init_options = lsp.init_options
  end

  if lsp.callbacks then
    setup.init_options = lsp.callbacks
  end

  lspconfig[name].setup(setup)
end

require("flutter-tools").setup{
  lsp = {
    on_attach = on_attach,
    capabilities = capabilities
  }
}

require('go').setup{
  linter = 'golint',
  lint_prompt_style = 'vt',
}

require('nlua.lsp.nvim').setup(
  require('lspconfig'),
  {
    on_attach = on_attach,
    capabilities = capabilities,
    globals = {
      "jit", "vim", "awesome", "window", "root", "client",
      "it", "describe", "before_each", "after_each"
  }
})

vim.cmd [[highlight link CompeDocumentation NormalFloat]]
