local nvim_lsp = require('nvim_lsp')
local lsp_status = require('lsp-status')
local diagnostic = require('diagnostic')
local completion = require('completion')

local severity_map = {'E', 'W', 'I', 'H'}

local function diagnostics_to_items(diagnostics)
  local items = {}
  local grouped = setmetatable({}, {
    __index = function(t, k)
      local v = {}
      rawset(t, k, v)
      return v
    end
  })

  local fname = vim.api.nvim_buf_get_name(0)
  for _, d in ipairs(diagnostics) do
    local range = d.range
    table.insert(grouped[fname], {start = range.start, item = d})
  end

  local keys = vim.tbl_keys(grouped)
  table.sort(keys)
  for _, name in ipairs(keys) do
    local rows = grouped[name]
    table.sort(rows, function(a, b)
      if a.start.line < b.start.line
        or (a.start.line == b.start.line and a.start.character < b.start.character) then
        return true
      end

      return false
    end)

    for _, row in ipairs(rows) do
      table.insert(items, {
        filename = name,
        lnum = row.start.line + 1,
        text = row.item.message,
        ['type'] = severity_map[row.item.severity],
        col = row.start.character + 1,
        vcol = true
      })
    end
  end

  return items
end

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local sumneko_command = function()
  local cache_location = vim.fn.stdpath('cache')

  -- TODO: Need to figure out where these paths are & how to detect max os... please, bug reports
  local bin_location = jit.os

  return {
    string.format(
      "%s/nvim_lsp/sumneko_lua/lua-language-server/bin/%s/lua-language-server",
      cache_location,
      bin_location
    ),
    "-E",
    string.format(
      "%s/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua",
      cache_location
    ),
  }
end

diagnostic.diagnostics_loclist = function(local_result)
  if local_result then for _, v in ipairs(local_result) do v.uri = v.uri or local_result.uri end end
  vim.lsp.util.set_loclist(diagnostics_to_items(local_result))
end

lsp_status.config {
  kind_labels = vim.g.completion_customize_lsp_label,
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ['start'] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[1])},
        ['end'] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[2])}
      }

      return require('lsp-status/util').in_range(cursor_pos, value_range)
    end
  end
}

lsp_status.register_progress()

local function make_on_attach(config)
  return function(client)
    if config.before then config.before(client) end

    lsp_status.on_attach(client)
    diagnostic.on_attach()
    completion.on_attach()
    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gA', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>e',
                                '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', ']e', '<cmd>NextDiagnosticCycle<cr>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '[e', '<cmd>PrevDiagnosticCycle<cr>', opts)

    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>',
                                  opts)
    end

    if config.filetypes and has_value(config.filetypes, 'lua')  then
      vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua keyword_program()<CR>', opts)
    else
      vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    end


    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_command('augroup lsp_aucmds')
      vim.api.nvim_command('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
      vim.api.nvim_command('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
      vim.api.nvim_command('augroup END')
    end

    if config.after then config.after(client) end
  end
end

local servers = {
  bashls = {},
  clangd = {
    cmd = {
      'clangd', -- '--background-index',
      '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
      '--suggest-missing-includes', '--cross-file-rename'
    },
    callbacks = lsp_status.extensions.clangd.setup(),
    init_options = {clangdFileStatus = true, usePlaceholders = true, completeUnimported = true}
  },
  clojure_lsp = {},
  -- ghcide = {},
  rust_analyzer = {},
  sumneko_lua = {
    cmd = sumneko_command(),
    filetypes = {"lua"},
    settings = {
      Lua = {
        diagnostics = {
          enabled = true,
          globals = vim.list_extend({
              "vim",
              "describe", "it", "before_each", "after_each",
            }, {}),
        },
        completion = {keywordSnippet = 'Disable'},
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        }
      }
    }
  },
  tsserver = {},
  rnix = {},
  vimls = {},
}

local snippet_capabilities = {
  textDocument = {completion = {completionItem = {snippetSupport = true}}}
}

local function deep_extend(policy, ...)
  local result = {}
  local function helper(policy, k, v1, v2)
    if type(v1) ~= 'table' or type(v2) ~= 'table' then
      if policy == 'error' then
        error('Key ' .. vim.inspect(k) .. ' is already present with value ' .. vim.inspect(v1))
      elseif policy == 'force' then
        return v2
      else
        return v1
      end
    else
      return deep_extend(policy, v1, v2)
    end
  end

  for _, t in ipairs({...}) do
    for k, v in pairs(t) do
      if result[k] ~= nil then
        result[k] = helper(policy, k, result[k], v)
      else
        result[k] = v
      end
    end
  end

  return result
end

for server, config in pairs(servers) do
  config.on_attach = make_on_attach(config)
  config.capabilities = deep_extend('keep',
                                    config.capabilities or {},
                                    lsp_status.capabilities,
                                    snippet_capabilities)

  nvim_lsp[server].setup(config)
end
