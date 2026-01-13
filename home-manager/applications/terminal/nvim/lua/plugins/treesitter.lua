return {

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "nix", "lua", "css", "csv", "c", "cpp", "git_rebase",
          "gitcommit", "gitignore", "html", "ini", "java", "javadoc",
          "jinja", "latex", "make", "markdown", "perl", "php", "python",
          "regex", "rust", "sql", "ssh_config", "toml", "yaml"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context"
  }

}

