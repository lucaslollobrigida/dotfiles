return {
  lazy_load = function(load)
    load "nvim-treesitter"
    load "nvim-ts-autotag"
    load "nvim-autopairs"
    load "todo-comments.nvim"
    load "nvim-comment"
    load "todo-comments"
  end,

  plugins = function(use)
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", opt = true }
    use { "windwp/nvim-ts-autotag", opt = true }
    use { "windwp/nvim-autopairs", opt = true }
    use {
      "folke/todo-comments.nvim",
      opt = true,
      requires = "nvim-lua/plenary.nvim",
    }
    use {
      "terrortylor/nvim-comment",
      opt = true,
    }
  end,

  setup = function()
    require("nvim_comment").setup()

    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "clojure",
        "dart",
        "fennel",
        "go",
        "haskell",
        "java",
        "lua",
        "nix",
        "python",
        "scala",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      playground = {
        enabled = true,
      },
      rainbow = {
        enabled = true,
      },
      indent = {
        enable = true,
        disable = { "yaml" },
      },
      autotag = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
    }

    require("nvim-autopairs").setup {
      check_ts = true,
      enable_check_bracket_line = false
    }

    require("nvim-treesitter.configs").setup {
      autopairs = { enable = true },
    }
  end,
}
