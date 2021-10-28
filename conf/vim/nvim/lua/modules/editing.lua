return {
  lazy_load = function(load)
    load "vim-easy-align"
    load "nvim-bqf"
  end,
  plugins = function(use)
    use { "tpope/vim-surround" }
    use { "tpope/vim-repeat"}
    use { "junegunn/vim-easy-align", opt = true }
    use { "kevinhwang91/nvim-bqf", opt = true }
  end,
  setup = function() end,
}
