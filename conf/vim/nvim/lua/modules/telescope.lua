local gen_from_quickfix = function(opts)
  local entry_display = require "telescope.pickers.entry_display"

  opts = opts or {}

  local displayer = entry_display.create {
    separator = "▏",
    items = {
      { width = 7 },
      { width = 98 },
      { width = 28 },
    },
  }

  local make_display = function(entry)
    local common = require "common"

    local filename = common.path_short(entry.filename)

    local line_info = { table.concat({ entry.lnum, entry.col }, ":"), "TelescopeResultsLineNr" }

    return displayer {
      line_info,
      entry.text:gsub(".* | ", ""),
      filename,
    }
  end

  return function(entry)
    local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)

    return {
      valid = true,

      value = entry,
      ordinal = filename .. " " .. entry.text,
      display = make_display,

      bufnr = entry.bufnr,
      filename = filename,
      lnum = entry.lnum,
      col = entry.col,
      text = entry.text,
      start = entry.start,
      finish = entry.finish,
    }
  end
end

return {
  lazy_load = function(load)
    load "plenary.nvim"
    load "popup.nvim"
    load "telescope-fzy-native.nvim"
    load "telescope.nvim"
    load "nvim-web-devicons"
    load "project.nvim"
  end,

  plugins = function(use)
    use {
      "nvim-telescope/telescope.nvim",
      opt = true,
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "kyazdani42/nvim-web-devicons",
      },
    }

    use { "lucaslollobrigida/project.nvim", branch = "main", opt = true }
  end,

  setup = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local sorters = require "telescope.sorters"
    local previewers = require "telescope.previewers"

    telescope.setup {
      defaults = {
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_fzy_sorter,

        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        buffer_previewer_maker = previewers.buffer_previewer_maker,

        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",

        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        fjle_ignore_patterns = {},
        path_display = { 3 },
        winblend = 0,
        layout_config = {
          horizontal = { mirror = false },
          vertical = { mirror = false },
          prompt_position = "bottom",
          width = 0.75,
          preview_cutoff = 120,
        },
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" },

        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-x>"] = false,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,

            -- Add up multiple actions
            ["<CR>"] = actions.select_default + actions.center,

            -- You can perform as many actions in a row as you like
            -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
          },
          n = {
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
        project = {
          locations = {
            { "/home/lollo/dev/nu", depth = 1 },
            { "/home/lollo/dev/personal", depth = 2 },
            { "/home/lollo/.dotfiles", depth = 1 },
            { "/etc/nixos", depth = 1 },
          },
        },
      },
    }

    telescope.load_extension "fzy_native"
  end,

  project_files = function()
    require("telescope.builtin").find_files {
      find_command = { "rg", "--files", "--hidden", "--color", "never", "--glob=!.git/*" },
    }
  end,

  git_branches = function()
    local actions = require "telescope.actions"

    require("telescope.builtin").git_branches {
      attach_mappings = function(_, map)
        map("i", "<c-d>", actions.git_delete_branch)
        map("n", "<c-d>", actions.git_delete_branch)
        return true
      end,
    }
  end,

  browse_projects = function()
    require("telescope").extensions.project.browse()
  end,

  lsp_references = function()
    require("telescope.builtin").lsp_references {
      entry_maker = gen_from_quickfix(),
    }
  end,

  lsp_code_action = function()
    require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor())
  end,

  lsp_range_code_action = function()
    require("telescope.builtin").lsp_range_code_actions(require("telescope.themes").get_cursor())
  end,
}
