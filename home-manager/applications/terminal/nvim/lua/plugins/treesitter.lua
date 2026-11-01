return {

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install{
        "nix", "lua", "css", "csv", "c", "cpp", "git_rebase", "kotlin",
        "gitcommit", "gitignore", "html", "ini", "java", "javadoc",
        "jinja", "latex", "make", "markdown", "perl", "php", "python",
        "regex", "rust", "sql", "ssh_config", "toml", "yaml", "qmljs"
      }
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          -- Treesitter highlighting
          pcall(vim.treesitter.start)
          -- Treesitter indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context"
  }

}

