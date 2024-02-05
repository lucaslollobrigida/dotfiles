return {
  lazy_load = function(load)
    load "neogit"
    load "gitlinker.nvim"
    load "plenary.nvim"
  end,
  plugins = function(use)
    use { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim", opt = true }
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("gitsigns").setup()
      end,
    }
    use {
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
      opt = true,
    }
  end,
  setup = function()
    require("neogit").setup{}
    require("gitlinker").setup {
      opts = {
        remote = nil,
        add_current_line_on_normal_mode = true,
        action_callback = require("gitlinker.actions").open_in_browser,
        print_url = false,
        mappings = "<leader>gy",
      },
      callbacks = {
        ["github.com"] = require("gitlinker.hosts").get_github_type_url,
        ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
      },
    }
  end,
}
