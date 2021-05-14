local C = require('config')

require'nvim-treesitter.configs'.setup {
    ensure_installed = C.treesitter.ensure_installed,
    ignore_install = C.treesitter.ignore_install,
    indent = {enable = {"javascriptreact"}},
    autotag = {enable = true},
    highlight = {
        enable = C.treesitter.highlight.enabled,
        use_languagetree = false,
    },
    incremental_selection = {
        enable = true,
    }
}

