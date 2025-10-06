return {

  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
      })
      -- I think nixd works. I don't know how to make this reproducable since it is a lua file. Maybe generate the lua file from a .nix lol
      vim.lsp.config( "nixd", {
        cmd = { "nixd" },
        settings = {
          nixd = {
            -- nixpkgs = { expr = "import (builtins.getFlake \"/home/${userSettings.username}/.dotfiles\").inputs.nixpkgs { }", },
            nixpkgs = { expr = "import (builtins.getFlake \"/home/ren/.dotfiles\").inputs.nixpkgs { }", },
            options = {
              -- nixos = { expr = "(builtins.getFlake \"/home/${userSettings.username}/.dotfiles\").nixosConfigurations.${userSettings.username}.options" },
              nixos = { expr = "(builtins.getFlake \"/home/ren/.dotfiles\").nixosConfigurations.nixos.options" },
              -- home_manager = { expr = "(builtins.getFlake \"/home/${userSettings.username}/.dotfiles\").homeConfigurations.${userSettings.username}.options" },
              home_manager = { expr = "(builtins.getFlake \"/home/ren/.dotfiles\").homeConfigurations.ren.options" },
            },
          },
        },
      })
      vim.lsp.enable("nixd")

      vim.lsp.config("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
      vim.lsp.enable("lua_ls")

      vim.lsp.config("jsonls", {
        settings = { trailingCommas = "ignore" },
      })
      vim.lsp.enable("jsonls")
      vim.lsp.enable("cssls")
    end,
  },

}

