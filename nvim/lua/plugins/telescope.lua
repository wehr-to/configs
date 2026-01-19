return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.9",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
  },
}
