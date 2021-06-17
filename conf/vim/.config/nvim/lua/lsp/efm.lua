local home = vim.loop.os_homedir()

-- local luaFormat = {
--     formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=120",
--     formatStdin = true
-- }

-- require('lspconfig.util').root_pattern('.stylua.toml')(require('plenary.path'):new(vim.api.nvim_buf_get_name(0)):absolute())
local stylua_config_path = string.format("%s/.dotfiles/.stylua.toml", home)

local lua_fmt = {
  formatCommand = string.format("stylua --config-path=%s -", stylua_config_path),
  formatStdin = true,
}

local shfmt = {
  formatCommand = "shfmt -ci -s -bn",
  formatStdin = true,
}

local shellcheck = {
  lintCommand = "shellcheck -f gcc -x",
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
}

-- tsserver/web javascript react, vue, json, html, css, yaml
local prettier = { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true }
-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}

local eslint = {
  lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true,
}

require("lspconfig").efm.setup({
  init_options = { documentFormatting = true, codeAction = false },
  filetypes = { "lua", "typescript", "typescriptreact", "javascript", "javascriptreact", "sh", "zsh", "json" },
  on_attach = require("lsp").on_attach,
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      lua = { lua_fmt },
      sh = { shfmt, shellcheck },
      javascript = { prettier, eslint },
      javascriptreact = { prettier, eslint },
      typescript = { prettier, eslint },
      typescriptreact = { prettier, eslint },
      json = { prettier },
    },
  },
})
