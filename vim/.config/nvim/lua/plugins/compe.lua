require'compe'.setup {
    enabled = true,
    autocomplete = true,
    documentation = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,

    source = {
        path = {kind = "   (Path)"},
        buffer = {kind = "   (Buffer)"},
        calc = {kind = "   (Calc)"},
        vsnip = {kind = "   (Snippet)"},
        nvim_lsp = {kind = "   (LSP)"},
        -- nvim_lua = {kind = "  "},
		nvim_lua = false,
        spell = {kind = "   (Spell)"},
        tags = false,
        vim_dadbod_completion = true,
        -- ultisnips = {kind = "  "},
        treesitter = {kind = "  "},
        emoji = {kind = " ﲃ  (Emoji)", filetypes={"markdown", "text"}}
    }
}

vim.cmd [[highlight link CompeDocumentation NormalFloat]]

vim.cmd [[imap <expr> <C-y>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>']]
vim.cmd [[smap <expr> <C-y>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>']]

vim.cmd [[imap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-j>']]
vim.cmd [[smap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-j>']]
vim.cmd [[imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>']]
vim.cmd [[smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>']]
