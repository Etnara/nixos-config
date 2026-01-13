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

      nodePackages.vscode-json-languageserver
      nodePackages.vscode-langservers-extracted

      nodePackages.intelephense
      clang
      pyright
      jdt-language-server
      rust-analyzer
      python3Packages.pylatexenc # Inline LaTeX
      # libtexprintf # Multiline LaTeX (No Package, try Distrobox)
    ];
  };

  home.file.".config/nvim".source = ./.;
  home.file.".config/nvim".recursive = true;
  imports = [ ./lua/plugins/lspconfig.nix ];

}

