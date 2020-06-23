-- nvim_lsp
local nvim_lsp = require 'nvim_lsp'
local setup_lsp = function(_)
  require'diagnostic'.on_attach()
  require'completion'.on_attach({
  sorter = 'alphabet',
  matcher = {'exact', 'fuzzy'}
  })
end

nvim_lsp.pyls.setup{
  on_attach = setup_lsp;
  root_dir = function(fname)
  return nvim_lsp.util.find_git_ancestor(fname) or nvim_lsp.util.path.dirname(fname)
  end;
}

nvim_lsp.gopls.setup{
  on_attach = setup_lsp;
}

nvim_lsp.rust_analyzer.setup{
   capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        completionItem = {
          deprecatedSupport = true,
          snippetSupport = true
        },
        contextSupport = true,
        dynamicRegistration = true
      }
    }
  },
  on_attach = setup_lsp;
}

-- colorizer.nvim
-- require'colorizer'.setup()

-- terminal.nvim
require'terminal'.setup()
