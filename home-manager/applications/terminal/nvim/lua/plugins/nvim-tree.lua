return {

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {
        update_focused_file = { enable = true, },
        renderer = {
          indent_markers = {
            enable = true,
          },
        },
        view = {
          side = "right",
          -- relativenumber = true,
          float = {
            enable = false,
            open_win_config = {
              width = 60,
            },
          },
        },
        filters = {
          custom = { "\\.git" },
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

}
