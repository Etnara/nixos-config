{ systemSettings, userSettings, ... }:

{
  home.file.".config/nvim/lua/plugins/lspconfig.lua".text = ''
    return {

      {
        "neovim/nvim-lspconfig",
        config = function()
          vim.diagnostic.config({
            virtual_text = true,
          })
          vim.lsp.config( "nixd", {
            cmd = { "nixd" },
            settings = {
              nixd = {
                nixpkgs = { expr = "import (builtins.getFlake \"/home/${userSettings.username}/.dotfiles\").inputs.nixpkgs { }", },
                options = {
                  nixos = { expr = "(builtins.getFlake \"/home/${userSettings.username}/.dotfiles\").nixosConfigurations.${systemSettings.hostname}.options" },
                  home_manager = { expr = "(builtins.getFlake \"/home/${userSettings.username}/.dotfiles\").homeConfigurations.${userSettings.username}.options" },
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

          vim.lsp.config("intelephense", {
            init_options = {
              globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
            }
          })
          vim.lsp.enable("intelephense")
          vim.lsp.enable("clangd")
          vim.lsp.enable("pyright")
          vim.lsp.enable("jdtls")
          vim.lsp.enable("rust_analyzer")
        end,
      },
    }
  '';
}

