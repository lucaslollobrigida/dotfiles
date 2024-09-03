local actions = require("telescope.actions")

return {
  "nvim-telescope/telescope.nvim",
  keys = function()
    return {
      {
        "<leader>ss",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Search terms in the project",
      },
      {
        "<leader>s*",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "Search term under cursor in the project",
      },
      {
        "<leader>,",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "List open buffers",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            find_command = { "rg", "--files", "--hidden", "--color", "never", "--glob=!.git/*" },
          })
        end,
        desc = "Open project files",
      },
      {
        "<leader>p",
        function()
          require("telescope").extensions.project.browse()
        end,
        desc = "Open projects",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            find_command = { "rg", "--files", "--hidden", "--color", "never", "--glob=!.git/*" },
          })
        end,
        desc = "Open project files",
      },
    }
  end,
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-x>"] = false,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,

          ["<CR>"] = actions.select_default + actions.center,
        },
        n = {
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        },
      },
    },
    extensions = {
      project = {
        locations = {
          { "/Users/lucas.lollobrigida/dev/nu", depth = 1 },
          { "/Users/lucas.lollobrigida/dev/personal", depth = 1 },
        },
      },
    },
  },
}
