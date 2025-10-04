{ pkgs, ...  }:

{

  home.file.".local/share/fonts".source = ./.;
  home.file.".local/share/fonts".recursive = true;

}

