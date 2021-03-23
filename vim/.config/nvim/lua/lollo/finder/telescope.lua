local has_telescope = pcall(Packadd, [[telescope.nvim]])

if not has_telescope then
  print('[finder/telescope] telescope.nvim is required for this package.')
end

Packadd [[plenary.nvim]]
Packadd [[popup.nvim]]
Packadd [[telescope-fzy-native.nvim]]
Packadd [[telescope-fzf-writer.nvim]]
Packadd [[sql.nvim]]
Packadd [[telescope-frecency.nvim]]
-- Packadd [[telescope-project.nvim]]

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--hidden',
      '--smart-case',
      '--glob=!.git/*',
    },
    set_env = { ['COLORTERM'] = 'truecolor' },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
      },
    }
  },
  extensions = {
    fzf_writer = {
      use_highlighter = true,
    },
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

telescope.load_extension("frecency")
telescope.load_extension('fzy_native')
-- telescope.load_extension('project') -- TODO: make my own

local M = {}

local function git_branches()
    require("telescope.builtin").git_branches({
        attach_mappings = function(prompt_bufnr, map) 
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

M.git_branches = git_branches

-- search
Nnoremap {'<leader>s', [[<cmd>lua require('telescope').extensions.fzf_writer.staged_grep()<cr>]]}
Nnoremap {'<leader>*', [[<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand("<cword>")})<cr>]]}

-- files
Nnoremap {'<leader>f', [[<cmd>lua require('telescope').extensions.fzf_writer.files()<cr>]]}
Nnoremap {'<leader><leader>', [[<cmd>lua require('telescope.builtin').git_files()<cr>]]}

-- experimental
Nnoremap {'<leader>asdf', [[<cmd>lua require('telescope').extensions.frecency.frecency()<cr>]]}

-- buffers
Nnoremap {'<leader>,', [[<cmd>lua require('telescope.builtin').buffers()<cr>]]}

-- git
Nnoremap {'<leader>b', [[<cmd>lua require('lollo.finder.telescope').git_branches()<CR>]]}

return M
