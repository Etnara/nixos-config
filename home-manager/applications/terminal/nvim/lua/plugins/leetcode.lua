return {

  {
    "kawre/leetcode.nvim",
    lazy = false,
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      arg = "leetcode.nvim",
      lang = "c",
      picker = { provider = "telescope" },
    }
  }

}

