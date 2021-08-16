local C = require "config"

require("compe").setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,

  documentation = {
    border = "rounded",
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },

  source = {
    path = { kind = "   (Path)" },
    luasnip = { kind = "   (Snippet)" },
    nvim_lsp = { kind = "   (LSP)" },
    -- conjure = { kind = "   (Conjure)" },
    -- spell = { kind = "   (Spell)" },
    treesitter = false, -- { kind = "  " },
    emoji = { kind = " ﲃ  (Emoji)", filetypes = { "markdown", "text" } },
  },
}

-- vim.g.vsnip_snippet_dir = string.format("%s/vsnip", C.paths.data)

-- vim.cmd([[imap <expr> <C-y>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>']])
-- vim.cmd([[smap <expr> <C-y>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>']])

-- vim.cmd([[imap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>']])
-- vim.cmd([[smap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>']])
-- vim.cmd([[imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>']])
-- vim.cmd([[smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>']])

local commonsnip_path = string.format("%s/site/pack/packer/opt/friendly-snippets/", C.paths.data)
local customsnip_path = string.format("%s/snippets/", C.paths.data)

vim.opt.runtimepath:append(commonsnip_path)
vim.opt.runtimepath:append(customsnip_path)

local loader = require "luasnip/loaders/from_vscode"
loader.load()

vim.api.nvim_exec(
  [[
  imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>

  snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(1)<Cr>
  snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(-1)<Cr>

  imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']],
  true
)
