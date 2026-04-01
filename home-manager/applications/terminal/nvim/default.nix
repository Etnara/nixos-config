{ pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      tree-sitter # For LaTeX tree-sitter
      ripgrep
      nixd
      lua-language-server

      vscode-json-languageserver
      vscode-langservers-extracted

      intelephense
      clang
      pyright
      jdt-language-server
      rust-analyzer
      python3Packages.pylatexenc # Inline LaTeX
      # libtexprintf # Multiline LaTeX (No Package, try Distrobox)
      kdePackages.qtdeclarative # qmlls
    ];
  };

  home.file.".config/nvim".source = ./.;
  home.file.".config/nvim".recursive = true;
  imports = [ ./lua/plugins/lspconfig.nix ];

}

