local has_lsp = pcall(vim.cmd, [[packadd nvim-lspconfig]])
if not has_lsp then
  print('[LSP] nvim-lspconfig is required for this package.')
  return
end
local api = vim.api

vim.cmd [[packadd popfix]]
vim.cmd [[packadd nvim-lsputils]]
vim.cmd [[packadd lsp_extensions.nvim]]
vim.cmd [[packadd nvim-compe]]
vim.cmd [[packadd compe-conjure]]
vim.cmd [[packadd flutter-tools.nvim]]

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
    snippets_nvim = false;
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
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  end

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  vim.cmd [[autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]]

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

local sumneko_command = function()
  local cache_location = vim.fn.stdpath('cache')
  local bin_folder = jit.os == 'Linux' and 'Linux' or 'macOS'

  return {
    string.format(
      "%s/lspconfig/lua-language-server/bin/%s/lua-language-server",
      cache_location,
      bin_folder
    ),
    "-E",
    string.format(
      "%s/lspconfig/lua-language-server/main.lua",
      cache_location
    ),
  }
end

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
  {'sumneko_lua',
    cmd = sumneko_command,
    settings = {Lua = {diagnostics = { enable = true, globals = {"jit", "vim", "awesome", "window", "root", "client", "it", "describe", "before_each", "after_each"}}}}},
  {'vimls', cmd = vimls_command},
  {'gopls'},
  {'rust_analyzer'},
  {'elixirls'},
  {'clojure_lsp', init_options = {extendedClientCapabilities = {classFileContentsSupport = true}}}
}

for _, lsp in ipairs(servers) do
  local name = lsp[1]
  local setup = { on_attach = on_attach }

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
  }
}
