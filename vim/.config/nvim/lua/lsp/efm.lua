local C = require('config')

-- local luaFormat = {
--     formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=120",
--     formatStdin = true
-- }

local lua_fmt = {
    formatCommand = "luafmt --indent-count 2 --line-width 120 --stdin",
    formatStdin = true
}

local shfmt = {
    formatCommand = 'shfmt -ci -s -bn',
    formatStdin = true
}

local shellcheck = {
    lintCommand = 'shellcheck -f gcc -x',
    lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
}

-- tsserver/web javascript react, vue, json, html, css, yaml
local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}

local eslint = {
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

require"lspconfig".efm.setup {
    -- init_options = {initializationOptions},
    cmd = {C.paths.data .. "/lspinstall/efm/efm-langserver"},
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = { "lua", "typescript", "typescriptreact", "javascript", "javascriptreact", "sh", "zsh", "json" },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = { lua_fmt },
            sh = { shfmt, shellcheck },
            javascript = { prettier, eslint },
            javascriptreact = { prettier, eslint },
			typescript = { prettier, eslint },
			typescriptreact = { prettier, eslint },
            json = {prettier},
        }
    }
}
