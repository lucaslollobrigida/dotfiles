local telescope = require('telescope')
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')

telescope.setup {
    defaults = {
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_generic_fuzzy_sorter,

        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        buffer_previewer_maker = previewers.buffer_previewer_maker,

        find_command = {
			'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden', '--glob=!.git/*'
		},

        prompt_position = "bottom",
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",

        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_defaults = {horizontal = {mirror = false}, vertical = {mirror = false}},
        file_ignore_patterns = {},
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},

        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'},

        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-x>"] = false,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            }
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        project = {
            locations = {
                {'/Users/lucas.lollobrigida/dev/personal', depth = 2},
                {'/Users/lucas.lollobrigida/dev/nu', depth = 1},
                {'/Users/lucas.lollobrigida/.dotfiles', depth = 1}
            }
        },
    }
}

telescope.load_extension('fzy_native')
telescope.load_extension("flutter")

local M = {}

M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

M.flutter_commands = function()
    require('telescope').extensions.flutter.commands()
end

return M
