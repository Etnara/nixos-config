return {

  {
    "norcalli/nvim-colorizer.lua",
    config = function ()
      vim.opt.termguicolors = true -- Need to set before plugin is loaded
      require("colorizer").setup()
    end,
  },

}

