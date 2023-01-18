return {
  lazy_load = function(load)
    load "conjure"
  end,
  plugins = function(use)
    use {
      "iamcco/markdown-preview.nvim",
      opt = true,
      run = "cd app && npm install",
      ft = { "markdown" },
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    }
  end,
  setup = function()
  end,
}

