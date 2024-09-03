return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = function()
    return {
      {
        "-",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
    }
  end,
}
