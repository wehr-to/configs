return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>n", "<cmd>Neotree filesystem reveal left<cr>", desc = "Neo-tree reveal left" },
  },
  config = function()
    require("neo-tree").setup({})
  end,
}
