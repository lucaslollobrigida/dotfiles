local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

require("lir").setup({
  show_hidden_files = true,
  devicons_enable = true,
  mappings = {
    ["<CR>"] = actions.edit,
    ["<C-s>"] = actions.split,
    ["<C-v>"] = actions.vsplit,
    ["<C-t>"] = actions.tabedit,

    ["-"] = actions.up,
    ["<ESC>"] = actions.quit,

    ["d"] = actions.mkdir,
    ["%"] = actions.newfile,
    ["R"] = actions.rename,
    ["."] = actions.cd,
    ["Y"] = actions.yank_path,
    ["H"] = actions.toggle_show_hidden,
    ["D"] = actions.delete,

    ["J"] = function()
      mark_actions.toggle_mark()
      vim.cmd("normal! j")
    end,
    ["c"] = clipboard_actions.copy,
    ["x"] = clipboard_actions.cut,
    ["p"] = clipboard_actions.paste,
  },
  float = {
    size_percentage = 0.5,
    winblend = 15,
    border = true,
    borderchars = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },

    -- -- If you want to use `shadow`, set `shadow` to `true`.
    -- -- Also, if you set shadow to true, the value of `borderchars` will be ignored.
    -- shadow = false,
  },
  hide_cursor = true,
})

-- custom folder icon
require("nvim-web-devicons").setup({
  override = {
    lir_folder_icon = {
      icon = "",
      color = "#7ebae4",
      name = "LirFolderNode",
    },
  },
})

local M = {}

function M.lir_settings()
  vim.api.nvim_buf_set_keymap(
    0,
    "x",
    "J",
    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    { noremap = true, silent = true }
  )
end

vim.api.nvim_exec(
  [[
    augroup lir-settings
    autocmd!
    autocmd Filetype lir lua require("plugins.lir").lir_settings()
    augroup END
    ]],
  false
)

function M.file_browser()
  local folder_path = vim.fn.expand("%:p:h")
  require("lir.float").toggle(folder_path)
end

vim.cmd([[
  hi LirFloatNormal guibg=#32302f
  hi LirFloatBorder guifg=#7c6f64
  hi LirDir guifg=#7ebae4
  hi LirSymLink guifg=#7c6f64
  hi LirEmptyDirText guifg=#7c6f64
]])

return M
