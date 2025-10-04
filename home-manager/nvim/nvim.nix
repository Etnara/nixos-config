{ pkgs, ... }:

{

  programs.neovim = {
    enable = true;
  	vimdiffAlias = true;
    extraPackages = with pkgs; [
      nixd
      lua-language-server
      nodePackages.vscode-json-languageserver
      nodePackages.vscode-langservers-extracted
      ripgrep
    ];
  };

  home.file.".config/nvim".source = ./.;
  home.file.".config/nvim".recursive = true;

  home.sessionVariables.EDITOR = "nvim";

}

